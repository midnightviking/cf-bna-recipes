import { getDb } from '$lib/server/db';
import { recipes, recipe_ingredients, ingredients as ingredientsTable, units as unitsTable, extensions, alternate_ingredients } from '$lib/server/db/schema.js';
import { eq, inArray } from 'drizzle-orm';

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
    

  // Get alternate ingredients for this recipe
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
  // Parse extensions for each alternate
  
  // [extensionName] => { ingredients: []}
  let extIds = Array.from(
    new Set(
      alternates
        .flatMap(alt => alt.extensions ? alt.extensions.split(',').map(Number) : [])
    )
  );

  let extensionNames = (extIds.length > 0) ? 
    await db.select().from(extensions).where(inArray(extensions.id, extIds)) : [];
 
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





  return { ..._recipe, ingredients, extensions: extensionNames, alternates: alternatesWithExtensions() };
}
