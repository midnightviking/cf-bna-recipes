import {db} from '$lib/server/db';
import { cookbooks, cookbook_recipes, recipes as recipesTable, recipe_ingredients, ingredients as ingredientsTable, units as unitsTable } from '$lib/server/schema.js';
import { eq, asc } from 'drizzle-orm';
import { json } from '@sveltejs/kit';

function errorResponse(error) {
  console.error(error);
  return json({ error: error.message || error.toString() }, { status: 500 });
}

async function getRecipeWithIngredients(recipeId) {
  try {
    const recipe = (await db.select().from(recipesTable).where(eq(recipesTable.id, recipeId)))[0];
    if (!recipe) return null;
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
    return { ...recipe, ingredients };
  } catch (error) {
    throw error;
  }
}

export async function GET({ params } = {}) {
  try {
    const id = Number(params.id);
    const cb = (await db.select().from(cookbooks).where(eq(cookbooks.id, id)))[0];
    if (!cb) return json({ error: 'Cookbook not found' }, { status: 404 });
    const recipeRows = await db
      .select()
      .from(cookbook_recipes)
      .where(eq(cookbook_recipes.cookbook_id, id))
      .orderBy(asc(cookbook_recipes.ordering));
    const recipes = await Promise.all(
      recipeRows.map(r => getRecipeWithIngredients(r.recipe_id))
    );
    return json({ ...cb, recipes, recipeRows });
  } catch (error) {
    return errorResponse(error);
  }
}
