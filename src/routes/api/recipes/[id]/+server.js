import { getDbInitError } from '$lib/server/db';
// import { errorResponse } from '../+server.js';
import { getRecipeWithIngredients } from '$lib/server/recipes.js';

export async function GET({ params }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const { id } = params;
    if (!id) {
      return new Response(JSON.stringify({ error: 'Missing recipe id' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }
    const recipe = await getRecipeWithIngredients(Number(id));
    if (!recipe) {
      return new Response(JSON.stringify({ error: 'Recipe not found' }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      });
    }
    return new Response(JSON.stringify(recipe), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message || error.toString() }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
}
