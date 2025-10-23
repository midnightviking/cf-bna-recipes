
import { getDb, getDbInitError } from '$lib/server/db';
import { recipes, recipe_ingredients, recipe_sections, alternate_ingredients, extensions, ingredients as ingredientsTable, units as unitsTable } from '$lib/server/db/schema.js';
import { eq, inArray } from 'drizzle-orm';
import { getRecipeWithIngredients } from '$lib/server/recipes.js';
import { createRecipe, updateRecipe } from '$lib/server/recipe-operations.js';

function errorResponse(error) {
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

export async function GET({ locals }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();

    // 1. Fetch all recipes
    const allRecipes = await db.select().from(recipes);
    const recipeIds = allRecipes.map(r => r.id);

    if (recipeIds.length === 0) {
      return new Response(JSON.stringify([]), {
        headers: { 'Content-Type': 'application/json' }
      });
    }

    // 2. Fetch all ingredients for all recipes (with joins)
    const allIngredients = await db
      .select({
        id: recipe_ingredients.id,
        recipe_id: recipe_ingredients.recipe_id,
        ingredient_id: recipe_ingredients.ingredient_id,
        name: ingredientsTable.name,
        quantity: recipe_ingredients.quantity,
        unit_id: unitsTable.id,
        unit_name: unitsTable.name,
        ordering: recipe_ingredients.ordering,
        section_id: recipe_ingredients.section_id,
      })
      .from(recipe_ingredients)
      .leftJoin(ingredientsTable, eq(recipe_ingredients.ingredient_id, ingredientsTable.id))
      .leftJoin(unitsTable, eq(recipe_ingredients.unit, unitsTable.id))
      .where(inArray(recipe_ingredients.recipe_id, recipeIds));

    // 3. Fetch all sections for all recipes
    const allSections = await db
      .select()
      .from(recipe_sections)
      .where(inArray(recipe_sections.recipe_id, recipeIds));

    // 4. Fetch all alternates for all recipes (with joins)
    const allAlternates = await db
      .select({
        ...alternate_ingredients,
        recipe_id: alternate_ingredients.recipe_id,
        alternate_name: ingredientsTable.name,
        alternate_unit_name: unitsTable.name
      })
      .from(alternate_ingredients)
      .leftJoin(ingredientsTable, eq(alternate_ingredients.alternate_ingredient, ingredientsTable.id))
      .leftJoin(unitsTable, eq(alternate_ingredients.unit_id, unitsTable.id))
      .where(inArray(alternate_ingredients.recipe_id, recipeIds));

    // 5. Gather all extension IDs from alternates
    const extIds = Array.from(
      new Set(
        allAlternates.flatMap(alt =>
          alt.extensions ? alt.extensions.split(',').map(Number) : []
        )
      )
    );

    // 6. Fetch all extensions for these IDs
    const allExtensions = extIds.length
      ? await db.select().from(extensions).where(inArray(extensions.id, extIds))
      : [];

    // 7. Group and assemble results by recipe
    const ingredientsByRecipe = {};
    for (const ing of allIngredients) {
      if (!ingredientsByRecipe[ing.recipe_id]) ingredientsByRecipe[ing.recipe_id] = [];
      ingredientsByRecipe[ing.recipe_id].push(ing);
    }

    const sectionsByRecipe = {};
    for (const sec of allSections) {
      if (!sectionsByRecipe[sec.recipe_id]) sectionsByRecipe[sec.recipe_id] = [];
      sectionsByRecipe[sec.recipe_id].push(sec);
    }

    const alternatesByRecipe = {};
    for (const alt of allAlternates) {
      if (!alternatesByRecipe[alt.recipe_id]) alternatesByRecipe[alt.recipe_id] = [];
      alternatesByRecipe[alt.recipe_id].push(alt);
    }

    // Attach extensions to alternates as in original logic
    allExtensions.forEach(e => {
      e.ingredients = allAlternates
        .filter(a => a.extensions && a.extensions.split(',').map(Number).includes(e.id))
        .map(a => {
          const ingredient = allIngredients.find(i => i.ingredient_id === a.original_ingredient) || {};
          return {
            ...a,
            original: { ...ingredient }
          };
        });
    });

    // Assemble the final result
    const result = allRecipes.map(recipe => {
      const normalizedIngredients = (ingredientsByRecipe[recipe.id] || [])
        .map((i, idx) => ({
          ...i,
          ordering: i.ordering ?? idx,
        }))
        .sort((a, b) => (a.section_id ?? -1) - (b.section_id ?? -1) || (a.ordering ?? 0) - (b.ordering ?? 0));

      const sections = (sectionsByRecipe[recipe.id] || []).sort((a, b) => (a.ordering ?? 0) - (b.ordering ?? 0));
      // Group ingredients by section
      const sectionsWithIngredients = sections.map(s => ({
        ...s,
        ingredients: normalizedIngredients.filter(i => i.section_id === s.id),
      }));

      // Find ingredients not assigned to any section
      const unassignedIngredients = normalizedIngredients.filter(i => !i.section_id || !sections.some(s => s.id === i.section_id));
      let allSections = [...sectionsWithIngredients];
      if (unassignedIngredients.length > 0) {
        allSections = [
          {
            id: -1, // synthetic id
            name: 'Default',
            ordering: -1,
            ingredients: unassignedIngredients
          },
          ...sectionsWithIngredients
        ];
      }

      // Parse alternates and extensions
      const alternates = (alternatesByRecipe[recipe.id] || []).map(a => ({
        ...a,
        extensions: a.extensions ? a.extensions.split(',').map(Number) : [],
      }));

      return {
        ...recipe,
        ingredients: normalizedIngredients,
        sections: allSections,
        extensions: allExtensions,
        alternates,
      };
    });

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
    
    const inserted = await createRecipe(db, data);
    const recipe = await getRecipeWithIngredients(inserted.id, locals);
    
    return new Response(JSON.stringify(recipe), {
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
    
    await updateRecipe(db, data);
    const recipe = await getRecipeWithIngredients(data.id, locals);
    
    return new Response(JSON.stringify(recipe), {
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
