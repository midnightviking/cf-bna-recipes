import {db} from '$lib/server/db';
import { cookbooks, cookbook_recipes, recipes as recipesTable } from '$lib/server/schema.js';
import { eq, asc } from 'drizzle-orm';

function errorResponse(error) {
  console.error(error);
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

async function getCookbookWithRecipes(cookbookId) {
  try {
    const cb = (await db.select().from(cookbooks).where(eq(cookbooks.id, cookbookId)))[0];
    if (!cb) return null;
    const recipes = await db
      .select({
        ...recipesTable,
        ordering: cookbook_recipes.ordering
      })
      .from(cookbook_recipes)
      .leftJoin(recipesTable, eq(cookbook_recipes.recipe_id, recipesTable.id))
      .where(eq(cookbook_recipes.cookbook_id, cookbookId))
      .orderBy(asc(cookbook_recipes.ordering), asc(recipesTable.title));
    return { ...cb, recipes };
  } catch (error) {
    throw error;
  }
}

export async function GET() {
  try {
    const allCookbooks = await db.select().from(cookbooks);
    const result = await Promise.all(allCookbooks.map(cb => getCookbookWithRecipes(cb.id)));
    return new Response(JSON.stringify(result), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function POST({ request } = {}) {
  const data = await request.json();
  try {
    const [inserted] = await db.insert(cookbooks).values({
      name: data.name,
      description: data.description,
      created: data.created || Date.now()
    }).returning();
    if (Array.isArray(data.recipes)) {
      for (const r of data.recipes) {
        await db.insert(cookbook_recipes).values({
          cookbook_id: inserted.id,
          recipe_id: r.id,
          ordering: r.ordering
        });
      }
    }
    const cb = await getCookbookWithRecipes(inserted.id);
    return new Response(JSON.stringify(cb), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function PUT({ request } = {}) {
  const data = await request.json();
  try {
    await db.update(cookbooks).set({
      name: data.name,
      description: data.description,
      created: data.created
    }).where(eq(cookbooks.id, data.id));
    await db.delete(cookbook_recipes).where(eq(cookbook_recipes.cookbook_id, data.id));
    if (Array.isArray(data.recipes)) {
      for (const r of data.recipes) {
        await db.insert(cookbook_recipes).values({
          cookbook_id: data.id,
          recipe_id: r.id,
          ordering: r.ordering
        });
      }
    }
    const cb = await getCookbookWithRecipes(data.id);
    return new Response(JSON.stringify(cb), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function DELETE({ request } = {}) {
  const { id } = await request.json();
  try {
    await db.delete(cookbook_recipes).where(eq(cookbook_recipes.cookbook_id, id));
    await db.delete(cookbooks).where(eq(cookbooks.id, id));
    return new Response(JSON.stringify({ success: true }), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}
