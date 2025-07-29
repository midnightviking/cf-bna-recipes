import { getDb, getDbInitError } from '$lib/server/db';
import { extensions } from '$lib/server/db/schema.js';
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
		const result = await db.select().from(extensions);
		return new Response(JSON.stringify(result), {
			headers: { 'Content-Type': 'application/json' }
		});
	} catch (error) {
		return errorResponse(error);
	}
}

export async function POST(request = {}) {
	try {
		const dbInitError = getDbInitError();
		if (dbInitError) throw dbInitError;
		const db = await getDb();
		const { name } = await request.json();
		const [inserted] = await db.insert(extensions).values({ name }).returning();
		return new Response(JSON.stringify(inserted), {
			status: 201,
			headers: { 'Content-Type': 'application/json' }
		});
	} catch (error) {
		return errorResponse(error);
	}
}

export async function PUT(request = {}) {
	try {
		const dbInitError = getDbInitError();
		if (dbInitError) throw dbInitError;
		const db = await getDb();
		const { id, name } = await request.json();
		await db.update(extensions).set({ name }).where(eq(extensions.id, id));
		return new Response(JSON.stringify({ id, name }), {
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
		await db.delete(extensions).where(eq(extensions.id, id));
		return new Response(JSON.stringify({ success: true }), {
			headers: { 'Content-Type': 'application/json' }
		});
	} catch (error) {
		return errorResponse(error);
	}
}