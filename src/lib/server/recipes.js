import { getDb } from '$lib/server/db';
import { recipes, recipe_ingredients, ingredients as ingredientsTable, units as unitsTable, extensions, alternate_ingredients, recipe_sections } from '$lib/server/db/schema.js';
import { eq, inArray } from 'drizzle-orm';

function inc(locals, ms) {
  try { locals?.__metrics?.incQuery?.(ms); } catch {}
}

export async function getRecipeWithIngredients(recipeId, locals) {
  const db = await getDb();
  let s = performance.now();
  const _recipe = (await db.select().from(recipes).where(eq(recipes.id, recipeId)))[0];
  inc(locals, performance.now() - s);
  if (!_recipe) return null;
  s = performance.now();
  const ingredients = await db
    .select({
      id: recipe_ingredients.id,
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
    .where(eq(recipe_ingredients.recipe_id, recipeId));
  inc(locals, performance.now() - s);
  // Normalize ingredient ordering (prefer new ordering, fallback to legacy order, then row order)
  const normalizedIngredients = ingredients
    .map((i, idx) => ({
      ...i,
      ordering: i.ordering ?? idx,
    }))
    .sort((a, b) => (a.section_id ?? -1) - (b.section_id ?? -1) || (a.ordering ?? 0) - (b.ordering ?? 0));
  // Fetch sections and attach ingredients per section
  s = performance.now();
  const sections = await db
    .select()
    .from(recipe_sections)
    .where(eq(recipe_sections.recipe_id, recipeId));
  inc(locals, performance.now() - s);
  // Sort sections by their ordering
  sections.sort((a, b) => (a.ordering ?? 0) - (b.ordering ?? 0));
  const sectionsWithIngredients = sections.map((s) => ({
    ...s,
    ingredients: normalizedIngredients.filter((i) => i.section_id === s.id),
  }));
    

  // Get alternate ingredients for this recipe
  s = performance.now();
  const alternates = await db
    .select({
      ...alternate_ingredients,
      alternate_name: ingredientsTable.name,
      alternate_unit_name: unitsTable.name
    })
    .from(alternate_ingredients)
    .leftJoin(ingredientsTable, eq(alternate_ingredients.alternate_ingredient, ingredientsTable.id))
    .leftJoin(unitsTable, eq(alternate_ingredients.unit_id, unitsTable.id))
    .where(eq(alternate_ingredients.recipe_id, recipeId));
  inc(locals, performance.now() - s);
  // Parse extensions for each alternate
  
  // [extensionName] => { ingredients: []}
  let extIds = Array.from(
    new Set(
      alternates
        .flatMap(alt => alt.extensions ? alt.extensions.split(',').map(Number) : [])
    )
  );

  s = performance.now();
  let extensionNames = (extIds.length > 0) ? 
    await db.select().from(extensions).where(inArray(extensions.id, extIds)) : [];
  if (extIds.length > 0) inc(locals, performance.now() - s);
 
  extensionNames.forEach(e => {
    e.ingredients = alternates
      .filter(a => a.extensions && a.extensions.split(',').map(Number).includes(e.id))
      .map(a => {
        const ingredient = ingredients.find(i => i.ingredient_id === a.original_ingredient) || {};
        return {
          ...a,
          original:{
            ...ingredient,
          }
        };
      });
  });
  
  const alternatesWithExtensions = () => {

    return alternates.map(a => ({
      ...a,
      extensions: a.extensions ? a.extensions.split(',').map(Number) : [] // keep property for now for compatibility
    }));
  };





  return { ..._recipe, ingredients: normalizedIngredients, sections: sectionsWithIngredients, extensions: extensionNames, alternates: alternatesWithExtensions() };
}
