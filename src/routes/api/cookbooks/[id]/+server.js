import { getDb, getDbInitError } from '$lib/server/db';
import { cookbooks, cookbook_recipes,  recipe_ingredients, ingredients as ingredientsTable, units as unitsTable, alternate_ingredients, extensions } from '$lib/server/db/schema.js';
import { eq, asc } from 'drizzle-orm';
import { json } from '@sveltejs/kit';
import { getRecipeWithIngredients } from '$lib/server/recipes.js';
function errorResponse(error) {
  return json({ error: error.message || error.toString() }, { status: 500 });
}


export async function GET({ params } = {}) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
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
