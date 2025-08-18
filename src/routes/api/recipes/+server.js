
import { getDb, getDbInitError } from '$lib/server/db';
import { recipes, recipe_ingredients, recipe_extensions, alternate_ingredients, extensions, recipe_sections } from '$lib/server/db/schema.js';
import { eq, inArray, and } from 'drizzle-orm';
import { getRecipeWithIngredients } from '$lib/server/recipes.js';

function errorResponse(error) {
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

// ...getRecipeWithIngredients is now imported from $lib/server/recipes.js...

export async function GET({ locals }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
  const allRecipes = await db.select().from(recipes);
  const t0 = performance.now();
  const result = await Promise.all(allRecipes.map(r => getRecipeWithIngredients(r.id, locals)));
  const t1 = performance.now();
  locals?.__metrics?.incQuery?.(t1 - t0);
    return new Response(JSON.stringify(result), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function POST({ request, locals }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const data = await request.json();
    const [inserted] = await db.insert(recipes).values({
      title: data.title,
      minTemp: data.minTemp,
      itemType: data.itemType,
      portionSize: data.portionSize,
      calories: data.calories,
      protein: data.protein,
      category: data.category,
      instructions: data.instructions,
      ccp: data.ccp,
      substitutions: data.substitutions,
      initialServings: data.initialServings
    }).returning();
    // Sections (optional): create first so we can reference section ids (batch insert)
    let sectionIdMap = new Map();
    if (Array.isArray(data.sections) && data.sections.length) {
      // Ensure stable ordering values
      const orderedSections = data.sections
        .map((s, idx) => ({ ...s, ordering: s.ordering ?? idx }))
        .sort((a, b) => (a.ordering ?? 0) - (b.ordering ?? 0));

      const toInsert = orderedSections.map((s) => ({
        recipe_id: inserted.id,
        name: s.name ?? '',
        ordering: s.ordering ?? 0,
      }));
      const insertedSections = toInsert.length
        ? await db.insert(recipe_sections).values(toInsert).returning()
        : [];
      // Map by original identifier (prefer provided id else name) to real id
      insertedSections.forEach((sec, i) => {
        const key = orderedSections[i].id ?? orderedSections[i].name;
        sectionIdMap.set(key, sec.id);
      });
    }

    if (Array.isArray(data.ingredients) && data.ingredients.length) {
      const rows = data.ingredients.map((ing, idx) => {
        const resolvedSection =
          (typeof ing.section_id === 'number' && ing.section_id > 0)
            ? ing.section_id
            : (ing.section ? sectionIdMap.get(ing.section) : null);
        const section_id = resolvedSection ?? null;
        const ordering = ing.ordering ?? ing.order ?? idx;
        return {
          recipe_id: inserted.id,
          ingredient_id: ing.ingredient_id,
          quantity: ing.quantity,
          unit: ing.unit_id,
          section_id,
          ordering,
        };
      });
      await db.insert(recipe_ingredients).values(rows);
    }
    // Insert recipe extensions (batch)
    if (Array.isArray(data.extensions) && data.extensions.length) {
      await db.insert(recipe_extensions).values(
        data.extensions.map((eid) => ({ recipe_id: inserted.id, extension_id: eid }))
      );
    }
    // Insert alternate ingredients (batch)
    if (Array.isArray(data.alternates) && data.alternates.length) {
      await db.insert(alternate_ingredients).values(
        data.alternates.map((alt) => ({
          recipe_id: inserted.id,
          original_ingredient: alt.original_ingredient,
          alternate_ingredient: alt.alternate_ingredient,
          quantity: alt.quantity,
          unit_id: alt.unit_id,
          extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : ''
        }))
      );
    }
  const _recipe = await getRecipeWithIngredients(inserted.id, locals);
    return new Response(JSON.stringify(_recipe), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function PUT({ request, locals }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const data = await request.json();
    await db.update(recipes).set({
      title: data.title,
      minTemp: data.minTemp,
      itemType: data.itemType,
      portionSize: data.portionSize,
      calories: data.calories,
      protein: data.protein,
      category: data.category,
      instructions: data.instructions,
      ccp: data.ccp,
      substitutions: data.substitutions,
      initialServings: data.initialServings
    }).where(eq(recipes.id, data.id));

  // Upsert sections with stable IDs, minimal writes
    let sectionIdMap = new Map();
    if (Array.isArray(data.sections)) {
      const orderedSections = data.sections
        .map((s, idx) => ({ ...s, ordering: s.ordering ?? idx }))
        .sort((a, b) => (a.ordering ?? 0) - (b.ordering ?? 0));

      // Load existing sections for this recipe
      const existing = await db.select().from(recipe_sections).where(eq(recipe_sections.recipe_id, data.id));
      const existingById = new Map(existing.map((e) => [e.id, e]));
      const incomingIds = new Set(orderedSections.filter((s) => typeof s.id === 'number').map((s) => s.id));
      const existingIds = new Set(existing.map((e) => e.id));

      // Updates for sections that already exist and actually changed
      for (const s of orderedSections) {
        if (typeof s.id === 'number' && existingById.has(s.id)) {
          const cur = existingById.get(s.id);
          if (cur.name !== (s.name ?? '') || (cur.ordering ?? 0) !== (s.ordering ?? 0)) {
            await db
              .update(recipe_sections)
              .set({ name: s.name ?? '', ordering: s.ordering ?? 0 })
              .where(eq(recipe_sections.id, s.id));
          }
          // map both by id and name for ingredient lookups
          sectionIdMap.set(s.id, s.id);
          if (s.name) sectionIdMap.set(s.name, s.id);
        }
      }

      // Inserts for new sections (no id)
      const toInsert = orderedSections.filter((s) => typeof s.id !== 'number').map((s) => ({
        recipe_id: data.id,
        name: s.name ?? '',
        ordering: s.ordering ?? 0,
      }));
      const insertedSections = toInsert.length
        ? await db.insert(recipe_sections).values(toInsert).returning()
        : [];
      // Map new ones by provided surrogate key (id or name)
      let insertIndex = 0;
      for (const s of orderedSections) {
        if (typeof s.id !== 'number') {
          const sec = insertedSections[insertIndex++];
          const key = s.id ?? s.name;
          if (key != null) sectionIdMap.set(key, sec.id);
          if (s.name) sectionIdMap.set(s.name, sec.id);
        }
      }

      // Deletions: existing sections not present in incoming list
      const toDeleteIds = [...existingIds].filter((eid) => !incomingIds.has(eid));
      if (toDeleteIds.length) {
        // First, unassign ingredients from these sections to avoid dangling refs
        await db
          .update(recipe_ingredients)
          .set({ section_id: null })
          .where(inArray(recipe_ingredients.section_id, toDeleteIds));
        await db.delete(recipe_sections).where(inArray(recipe_sections.id, toDeleteIds));
      }

      // Ensure existing sections are resolvable by name for ingredient mapping
      for (const e of existing) {
        sectionIdMap.set(e.id, e.id);
        if (e.name) sectionIdMap.set(e.name, e.id);
      }
    }
    // Update ingredients (diff-based: update changed, insert new, delete removed)
    const existingIngs = await db
      .select({ id: recipe_ingredients.id, ingredient_id: recipe_ingredients.ingredient_id, quantity: recipe_ingredients.quantity, unit: recipe_ingredients.unit, section_id: recipe_ingredients.section_id, ordering: recipe_ingredients.ordering })
      .from(recipe_ingredients)
      .where(eq(recipe_ingredients.recipe_id, data.id));
    const existingById = new Map(existingIngs.map((r) => [r.id, r]));
    const incomingIngs = Array.isArray(data.ingredients) ? data.ingredients : [];
    const incomingIds = new Set(incomingIngs.filter((i) => typeof i.id === 'number').map((i) => i.id));
    const existingIds = new Set(existingIngs.map((r) => r.id));

    // Updates
    for (const [idx, ing] of incomingIngs.entries()) {
      if (typeof ing.id === 'number' && existingById.has(ing.id)) {
        const cur = existingById.get(ing.id);
        const next = {
          ingredient_id: ing.ingredient_id,
          quantity: ing.quantity,
          unit: ing.unit_id,
          section_id:
            (typeof ing.section_id === 'number' && ing.section_id > 0)
              ? ing.section_id
              : (ing.section ? sectionIdMap.get(ing.section) : null),
          ordering: ing.ordering ?? ing.order ?? idx,
        };
        if (
          cur.ingredient_id !== next.ingredient_id ||
          String(cur.quantity) !== String(next.quantity) ||
          cur.unit !== next.unit ||
          (cur.section_id ?? null) !== (next.section_id ?? null) ||
          (cur.ordering ?? 0) !== (next.ordering ?? 0)
        ) {
          await db.update(recipe_ingredients).set(next).where(eq(recipe_ingredients.id, ing.id));
        }
      }
    }
    // Inserts
    const toInsertIngs = incomingIngs
      .map((ing, idx) => ({ ing, idx }))
      .filter(({ ing }) => typeof ing.id !== 'number')
      .map(({ ing, idx }) => ({
        recipe_id: data.id,
        ingredient_id: ing.ingredient_id,
        quantity: ing.quantity,
        unit: ing.unit_id,
        section_id:
          (typeof ing.section_id === 'number' && ing.section_id > 0)
            ? ing.section_id
            : (ing.section ? sectionIdMap.get(ing.section) : null),
        ordering: ing.ordering ?? ing.order ?? idx,
      }));
    if (toInsertIngs.length) {
      await db.insert(recipe_ingredients).values(toInsertIngs);
    }
    // Deletes
    const toDeleteIngIds = [...existingIds].filter((eid) => !incomingIds.has(eid));
    if (toDeleteIngIds.length) {
      await db.delete(recipe_ingredients).where(inArray(recipe_ingredients.id, toDeleteIngIds));
    }

    // Update recipe extensions (diff-based)
    if (Array.isArray(data.extensions)) {
      const existingExt = await db.select().from(recipe_extensions).where(eq(recipe_extensions.recipe_id, data.id));
      const existingExtIds = new Set(existingExt.map((e) => e.extension_id));
      const incomingExtIds = new Set(data.extensions);
      const toInsertExt = [...incomingExtIds].filter((eid) => !existingExtIds.has(eid));
      const toDeleteExt = [...existingExtIds].filter((eid) => !incomingExtIds.has(eid));
      if (toInsertExt.length) {
        await db.insert(recipe_extensions).values(toInsertExt.map((eid) => ({ recipe_id: data.id, extension_id: eid })));
      }
      if (toDeleteExt.length) {
        await db
          .delete(recipe_extensions)
          .where(
            and(
              eq(recipe_extensions.recipe_id, data.id),
              inArray(recipe_extensions.extension_id, toDeleteExt)
            )
          );
      }
    }

    // Update alternates (diff-based)
    const existingAlts = await db.select().from(alternate_ingredients).where(eq(alternate_ingredients.recipe_id, data.id));
    const existingAltById = new Map(existingAlts.map((a) => [a.id, a]));
    const incomingAlts = Array.isArray(data.alternates) ? data.alternates : [];
    const incomingAltIds = new Set(incomingAlts.filter((a) => typeof a.id === 'number').map((a) => a.id));
    const existingAltIds = new Set(existingAlts.map((a) => a.id));

    // Update existing alternates if changed
    for (const alt of incomingAlts) {
      if (typeof alt.id === 'number' && existingAltById.has(alt.id)) {
        const cur = existingAltById.get(alt.id);
        const next = {
          original_ingredient: alt.original_ingredient,
          alternate_ingredient: alt.alternate_ingredient,
          quantity: alt.quantity,
          unit_id: alt.unit_id,
          extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : (alt.extensions ?? ''),
        };
        if (
          cur.original_ingredient !== next.original_ingredient ||
          cur.alternate_ingredient !== next.alternate_ingredient ||
          String(cur.quantity) !== String(next.quantity) ||
          cur.unit_id !== next.unit_id ||
          (cur.extensions ?? '') !== (next.extensions ?? '')
        ) {
          await db.update(alternate_ingredients).set(next).where(eq(alternate_ingredients.id, alt.id));
        }
      }
    }
    // Insert new alternates
    const toInsertAlts = incomingAlts.filter((a) => typeof a.id !== 'number').map((alt) => ({
      recipe_id: data.id,
      original_ingredient: alt.original_ingredient,
      alternate_ingredient: alt.alternate_ingredient,
      quantity: alt.quantity,
      unit_id: alt.unit_id,
      extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : (alt.extensions ?? ''),
    }));
    if (toInsertAlts.length) {
      await db.insert(alternate_ingredients).values(toInsertAlts);
    }
    // Delete removed alternates
    const toDeleteAltIds = [...existingAltIds].filter((eid) => !incomingAltIds.has(eid));
    if (toDeleteAltIds.length) {
      await db.delete(alternate_ingredients).where(inArray(alternate_ingredients.id, toDeleteAltIds));
    }
  const _recipe = await getRecipeWithIngredients(data.id, locals);
    return new Response(JSON.stringify(_recipe), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function DELETE({ request }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const { id } = await request.json();
    await db.delete(recipe_ingredients).where(eq(recipe_ingredients.recipe_id, id));
    await db.delete(alternate_ingredients).where(eq(alternate_ingredients.recipe_id, id));
    await db.delete(recipes).where(eq(recipes.id, id));
    return new Response(JSON.stringify({ success: true }), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}
