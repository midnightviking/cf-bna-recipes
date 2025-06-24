import {db} from '$lib/server/db';
import { ingredients } from '$lib/server/schema.js';
import { eq } from 'drizzle-orm';

export async function GET() {
  const result = await db.select().from(ingredients);
  return new Response(JSON.stringify(result), {
    headers: { 'Content-Type': 'application/json' }
  });
}

export async function POST(request = {}) {
  const { name } = await request.json();
  const [inserted] = await db.insert(ingredients).values({ name }).returning();
  return new Response(JSON.stringify(inserted), {
    status: 201,
    headers: { 'Content-Type': 'application/json' }
  });
}

export async function PUT(request = {}) {
  const { id, name } = await request.json();
  await db.update(ingredients).set({ name }).where(eq(ingredients.id, id));
  return new Response(JSON.stringify({ id, name }), {
    headers: { 'Content-Type': 'application/json' }
  });
}

export async function DELETE(request = {}) {
  const { id } = await request.json();
  await db.delete(ingredients).where(eq(ingredients.id, id));
  return new Response(JSON.stringify({ success: true }), {
    headers: { 'Content-Type': 'application/json' }
  });
}
