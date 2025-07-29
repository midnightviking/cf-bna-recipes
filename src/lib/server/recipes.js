import { getDb } from '$lib/server/db';
import { recipes, recipe_ingredients, ingredients as ingredientsTable, units as unitsTable, extensions, recipe_extensions, alternate_ingredients } from '$lib/server/db/schema.js';
import { eq } from 'drizzle-orm';

export async function getRecipeWithIngredients(recipeId) {
  const db = await getDb();
  const _recipe = (await db.select().from(recipes).where(eq(recipes.id, recipeId)))[0];
  if (!_recipe) return null;
  const ingredients = await db
    .select({
      ingredient_id: recipe_ingredients.ingredient_id,
      name: ingredientsTable.name,
      quantity: recipe_ingredients.quantity,
      unit_id: unitsTable.id,
      unit_name: unitsTable.name
    })
    .from(recipe_ingredients)
    .leftJoin(ingredientsTable, eq(recipe_ingredients.ingredient_id, ingredientsTable.id))
    .leftJoin(unitsTable, eq(recipe_ingredients.unit, unitsTable.id))
    .where(eq(recipe_ingredients.recipe_id, recipeId));
    

  // Get extensions for this recipe
  const extensionRows = await db.select().from(recipe_extensions).where(eq(recipe_extensions.recipe_id, recipeId));
  const extensionIds = extensionRows.map(r => r.extension_id);
  // Get extension names
  let extensionNames = [];
  if (extensionIds.length > 0) {
    extensionNames = (await db.select().from(extensions).where(extensions.id.in(extensionIds))).map(r => r.name);
  }

  // Get alternate ingredients for this recipe
  const alternates = await db.select().from(alternate_ingredients).where(eq(alternate_ingredients.recipe_id, recipeId));
  // Parse extensions for each alternate
  const alternatesWithExtensions = alternates.map(a => ({
    ...a,
	  extensions: a.extensions ? a.extensions.split(',').map(Number) : [] // keep property for now for compatibility
  }));

  return { ..._recipe, ingredients, extensions: extensionIds, extensionNames, alternates: alternatesWithExtensions };
}
