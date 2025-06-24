import {db} from '$lib/server/db';
import { recipes, recipe_ingredients, ingredients as ingredientsTable, units as unitsTable } from '$lib/server/schema.js';
import { eq } from 'drizzle-orm';

function errorResponse(error) {
  console.error(error);
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

async function getRecipeWithIngredients( recipeId) {
  try {
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
    return { ..._recipe, ingredients };
  } catch (error) {
    throw error;
  }
}

export async function GET() {
  try {
    const allRecipes = await db.select().from(recipes);
    const result = await Promise.all(allRecipes.map(r => getRecipeWithIngredients(r.id)));
    return new Response(JSON.stringify(result), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function POST(request = {}) {
  try {
    const data = await request.json();
    const [inserted] = await db.insert(recipes).values({
      title: data.title,
      minTemp: data.minTemp,
      itemType: data.itemType,
      portionSize: data.portionSize,
      calories: data.calories,
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
    const _recipe = await getRecipeWithIngredients(inserted.id);
    return new Response(JSON.stringify(_recipe), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function PUT(request = {}) {
  try {
    const data = await request.json();
    await db.update(recipes).set({
      title: data.title,
      minTemp: data.minTemp,
      itemType: data.itemType,
      portionSize: data.portionSize,
      calories: data.calories,
      category: data.category,
      instructions: data.instructions,
      ccp: data.ccp,
      substitutions: data.substitutions,
      initialServings: data.initialServings
    }).where(eq(recipes.id, data.id));
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
    const _recipe = await getRecipeWithIngredients(data.id);
    return new Response(JSON.stringify(_recipe), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function DELETE(request  = {}) {
  try {
    const { id } = await request.json();
    await db.delete(recipe_ingredients).where(eq(recipe_ingredients.recipe_id, id));
    await db.delete(recipes).where(eq(recipes.id, id));
    return new Response(JSON.stringify({ success: true }), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}
