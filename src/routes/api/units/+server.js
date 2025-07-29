import { getDb, getDbInitError } from '$lib/server/db';
import { units } from '$lib/server/db/schema.js';
import { eq } from 'drizzle-orm';

function errorResponse(error) {
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

export async function GET() {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const _units = await db.select().from(units).all();
    return new Response(JSON.stringify(_units), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}


export async function POST({ request}) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const { name, conversion_unit, conversion_threshold, conversion_formula } = await request.json();
    const [inserted] = await db.insert(units).values({
      name,
      conversion_unit: conversion_unit || null,
      conversion_threshold: conversion_threshold === '' ? null : conversion_threshold,
      conversion_formula: conversion_formula || null
    }).returning();
    return new Response(JSON.stringify(inserted), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function PUT({ request}) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const { id, name, conversion_unit, conversion_threshold, conversion_formula } = await request.json();
    await db.update(units)
      .set({
        name,
        conversion_unit: conversion_unit || null,
        conversion_threshold: conversion_threshold === '' ? null : conversion_threshold,
        conversion_formula: conversion_formula || null
      })
      .where(eq(units.id, id));
    return new Response(JSON.stringify({ id, name, conversion_unit, conversion_threshold, conversion_formula }), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}

export async function DELETE({ request}) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const { id } = await request.json();
    await db.delete(units).where(eq(units.id, id));
    return new Response(JSON.stringify({ success: true }), {
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error);
  }
}