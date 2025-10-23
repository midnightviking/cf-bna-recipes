import { recipe_ingredients, recipe_extensions, alternate_ingredients, recipe_sections, recipes } from './db/schema.js';
import { eq, inArray, and } from 'drizzle-orm';

/**
 * Upsert sections for a recipe
 * @param {*} db - Database instance
 * @param {number} recipeId - Recipe ID
 * @param {Array} sections - Array of section objects
 * @returns {Map} - Map of section keys to real section IDs
 */
export async function upsertSections(db, recipeId, sections, isUpdate = false) {
  const sectionIdMap = new Map();
  
  if (!Array.isArray(sections) || sections.length === 0) {
    return sectionIdMap;
  }

  const orderedSections = sections
    .map((s, idx) => ({ ...s, ordering: s.ordering ?? idx }))
    .sort((a, b) => (a.ordering ?? 0) - (b.ordering ?? 0));

  if (isUpdate) {
    // Load existing sections for this recipe
    const existing = await db.select().from(recipe_sections).where(eq(recipe_sections.recipe_id, recipeId));
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
        sectionIdMap.set(s.id, s.id);
        if (s.name) sectionIdMap.set(s.name, s.id);
      }
    }

    // Inserts for new sections (no id)
    const toInsert = orderedSections.filter((s) => typeof s.id !== 'number').map((s) => ({
      recipe_id: recipeId,
      name: s.name ?? '',
      ordering: s.ordering ?? 0,
    }));
    const insertedSections = toInsert.length
      ? await db.insert(recipe_sections).values(toInsert).returning()
      : [];
    
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
      await db
        .update(recipe_ingredients)
        .set({ section_id: null })
        .where(inArray(recipe_ingredients.section_id, toDeleteIds));
      await db.delete(recipe_sections).where(inArray(recipe_sections.id, toDeleteIds));
    }

    // Ensure existing sections are resolvable by name
    for (const e of existing) {
      sectionIdMap.set(e.id, e.id);
      if (e.name) sectionIdMap.set(e.name, e.id);
    }
  } else {
    // Insert new sections for POST
    const toInsert = orderedSections.map((s) => ({
      recipe_id: recipeId,
      name: s.name ?? '',
      ordering: s.ordering ?? 0,
    }));
    const insertedSections = toInsert.length
      ? await db.insert(recipe_sections).values(toInsert).returning()
      : [];
    
    insertedSections.forEach((sec, i) => {
      const key = orderedSections[i].id ?? orderedSections[i].name;
      sectionIdMap.set(key, sec.id);
    });
  }

  return sectionIdMap;
}

/**
 * Upsert ingredients for a recipe
 */
export async function upsertIngredients(db, recipeId, ingredients, sectionIdMap, isUpdate = false) {
  if (!Array.isArray(ingredients) || ingredients.length === 0) {
    return;
  }

  if (isUpdate) {
    const existingIngs = await db
      .select({ 
        id: recipe_ingredients.id, 
        ingredient_id: recipe_ingredients.ingredient_id, 
        quantity: recipe_ingredients.quantity, 
        unit: recipe_ingredients.unit, 
        section_id: recipe_ingredients.section_id, 
        ordering: recipe_ingredients.ordering 
      })
      .from(recipe_ingredients)
      .where(eq(recipe_ingredients.recipe_id, recipeId));
    
    const existingById = new Map(existingIngs.map((r) => [r.id, r]));
    const incomingIds = new Set(ingredients.filter((i) => typeof i.id === 'number').map((i) => i.id));
    const existingIds = new Set(existingIngs.map((r) => r.id));

    // Updates
    for (const [idx, ing] of ingredients.entries()) {
      if (typeof ing.id === 'number' && existingById.has(ing.id)) {
        const cur = existingById.get(ing.id);
        const next = {
          ingredient_id: ing.ingredient_id,
          quantity: ing.quantity,
          unit: ing.unit_id,
          section_id: resolveSectionId(ing, sectionIdMap),
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
    const toInsert = ingredients
      .map((ing, idx) => ({ ing, idx }))
      .filter(({ ing }) => typeof ing.id !== 'number')
      .map(({ ing, idx }) => ({
        recipe_id: recipeId,
        ingredient_id: ing.ingredient_id,
        quantity: ing.quantity,
        unit: ing.unit_id,
        section_id: resolveSectionId(ing, sectionIdMap),
        ordering: ing.ordering ?? ing.order ?? idx,
      }));
    if (toInsert.length) {
      await db.insert(recipe_ingredients).values(toInsert);
    }

    // Deletes
    const toDeleteIds = [...existingIds].filter((eid) => !incomingIds.has(eid));
    if (toDeleteIds.length) {
      await db.delete(recipe_ingredients).where(inArray(recipe_ingredients.id, toDeleteIds));
    }
  } else {
    // Insert new ingredients for POST
    const rows = ingredients.map((ing, idx) => ({
      recipe_id: recipeId,
      ingredient_id: ing.ingredient_id,
      quantity: ing.quantity,
      unit: ing.unit_id,
      section_id: resolveSectionId(ing, sectionIdMap),
      ordering: ing.ordering ?? ing.order ?? idx,
    }));
    await db.insert(recipe_ingredients).values(rows);
  }
}

/**
 * Helper to resolve section_id from ingredient data
 */
function resolveSectionId(ing, sectionIdMap) {
  if (typeof ing.section_id === 'number' && ing.section_id > 0) {
    return ing.section_id;
  }
  if (ing.section && sectionIdMap.has(ing.section)) {
    return sectionIdMap.get(ing.section);
  }
  return null;
}

/**
 * Upsert extensions for a recipe
 */
export async function upsertExtensions(db, recipeId, extensions, isUpdate = false) {
  if (!Array.isArray(extensions)) {
    return;
  }

  if (isUpdate) {
    const existingExt = await db.select().from(recipe_extensions).where(eq(recipe_extensions.recipe_id, recipeId));
    const existingExtIds = new Set(existingExt.map((e) => e.extension_id));
    const incomingExtIds = new Set(extensions);
    const toInsert = [...incomingExtIds].filter((eid) => !existingExtIds.has(eid));
    const toDelete = [...existingExtIds].filter((eid) => !incomingExtIds.has(eid));
    
    if (toInsert.length) {
      await db.insert(recipe_extensions).values(toInsert.map((eid) => ({ recipe_id: recipeId, extension_id: eid })));
    }
    if (toDelete.length) {
      await db
        .delete(recipe_extensions)
        .where(
          and(
            eq(recipe_extensions.recipe_id, recipeId),
            inArray(recipe_extensions.extension_id, toDelete)
          )
        );
    }
  } else {
    if (extensions.length > 0) {
      await db.insert(recipe_extensions).values(
        extensions.map((eid) => ({ recipe_id: recipeId, extension_id: eid }))
      );
    }
  }
}

/**
 * Upsert alternates for a recipe
 */
export async function upsertAlternates(db, recipeId, alternates, isUpdate = false) {
  if (!Array.isArray(alternates)) {
    return;
  }

  if (isUpdate) {
    const existingAlts = await db.select().from(alternate_ingredients).where(eq(alternate_ingredients.recipe_id, recipeId));
    const existingAltById = new Map(existingAlts.map((a) => [a.id, a]));
    const incomingAltIds = new Set(alternates.filter((a) => typeof a.id === 'number').map((a) => a.id));
    const existingAltIds = new Set(existingAlts.map((a) => a.id));

    // Update existing alternates if changed
    for (const alt of alternates) {
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
    const toInsert = alternates.filter((a) => typeof a.id !== 'number').map((alt) => ({
      recipe_id: recipeId,
      original_ingredient: alt.original_ingredient,
      alternate_ingredient: alt.alternate_ingredient,
      quantity: alt.quantity,
      unit_id: alt.unit_id,
      extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : (alt.extensions ?? ''),
    }));
    if (toInsert.length) {
      await db.insert(alternate_ingredients).values(toInsert);
    }

    // Delete removed alternates
    const toDeleteIds = [...existingAltIds].filter((eid) => !incomingAltIds.has(eid));
    if (toDeleteIds.length) {
      await db.delete(alternate_ingredients).where(inArray(alternate_ingredients.id, toDeleteIds));
    }
  } else {
    if (alternates.length > 0) {
      await db.insert(alternate_ingredients).values(
        alternates.map((alt) => ({
          recipe_id: recipeId,
          original_ingredient: alt.original_ingredient,
          alternate_ingredient: alt.alternate_ingredient,
          quantity: alt.quantity,
          unit_id: alt.unit_id,
          extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : ''
        }))
      );
    }
  }
}

/**
 * Create a new recipe with all related data
 */
export async function createRecipe(db, data) {
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

  const sectionIdMap = await upsertSections(db, inserted.id, data.sections, false);
  await upsertIngredients(db, inserted.id, data.ingredients, sectionIdMap, false);
  await upsertExtensions(db, inserted.id, data.extensions, false);
  await upsertAlternates(db, inserted.id, data.alternates, false);

  return inserted;
}

/**
 * Update an existing recipe with all related data
 */
export async function updateRecipe(db, data) {
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

  const sectionIdMap = await upsertSections(db, data.id, data.sections, true);
  await upsertIngredients(db, data.id, data.ingredients, sectionIdMap, true);
  await upsertExtensions(db, data.id, data.extensions, true);
  await upsertAlternates(db, data.id, data.alternates, true);
}
