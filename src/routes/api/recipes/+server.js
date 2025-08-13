
import { getDb, getDbInitError } from '$lib/server/db';
import { recipes, recipe_ingredients, recipe_extensions, alternate_ingredients, extensions } from '$lib/server/db/schema.js';
import { eq } from 'drizzle-orm';
import { getRecipeWithIngredients } from '$lib/server/recipes.js';

function errorResponse(error) {
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

// ...getRecipeWithIngredients is now imported from $lib/server/recipes.js...

export async function GET() {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const allRecipes = await db.select().from(recipes);
    const result = await Promise.all(allRecipes.map(r => getRecipeWithIngredients(r.id)));
    return new Response(JSON.stringify(result), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function POST({ request }) {
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
    if (Array.isArray(data.ingredients)) {
      for (const ing of data.ingredients) {
        await db.insert(recipe_ingredients).values({
          recipe_id: inserted.id,
          ingredient_id: ing.ingredient_id,
          quantity: ing.quantity,
          unit: ing.unit_id
        });
      }
    }
    // Insert recipe extensions
    if (Array.isArray(data.extensions)) {
      for (const eid of data.extensions) {
        await db.insert(recipe_extensions).values({ recipe_id: inserted.id, extension_id: eid });
      }
    }
    // Insert alternate ingredients
    if (Array.isArray(data.alternates)) {
      for (const alt of data.alternates) {
        await db.insert(alternate_ingredients).values({
          recipe_id: inserted.id,
          original_ingredient: alt.original_ingredient,
          alternate_ingredient: alt.alternate_ingredient,
          quantity: alt.quantity,
          unit_id: alt.unit_id,
          extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : ''
        });
      }
    }
    const _recipe = await getRecipeWithIngredients(inserted.id);
    return new Response(JSON.stringify(_recipe), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function PUT({ request }) {
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

    // Update ingredients
    await db.delete(recipe_ingredients).where(eq(recipe_ingredients.recipe_id, data.id));
    if (Array.isArray(data.ingredients)) {
      for (const ing of data.ingredients) {
        await db.insert(recipe_ingredients).values({
          recipe_id: data.id,
          ingredient_id: ing.ingredient_id,
          quantity: ing.quantity,
          unit: ing.unit_id
        });
      }
    }
    // Update alternates
    await db.delete(alternate_ingredients).where(eq(alternate_ingredients.recipe_id, data.id));
    if (Array.isArray(data.alternates)) {
      for (const alt of data.alternates) {
        await db.insert(alternate_ingredients).values({
          recipe_id: data.id,
          original_ingredient: alt.original_ingredient,
          alternate_ingredient: alt.alternate_ingredient,
          quantity: alt.quantity,
          unit_id: alt.unit_id,
          extensions: Array.isArray(alt.extensions) ? alt.extensions.join(',') : alt.extensions
        });
      }
    }
    const _recipe = await getRecipeWithIngredients(data.id);
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
