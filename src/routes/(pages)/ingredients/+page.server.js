/** @type {import('./$types').PageServerLoad} */
export async function load({ fetch, params }) {
    return {
        ingredients: await fetch('/api/ingredients').then((d) => d.json())
    };
};

import { getDb, getDbInitError } from '$lib/server/db';
import { ingredients as ingredientsTable } from '$lib/server/schema.js';
import { eq } from 'drizzle-orm';

/** @satisfies {import('./$types').Actions} */
export const actions = {
    save: async ({ request }) => {
        const data = await request.formData();
        const id = data.get("id");
        const name = data.get("name");

        const dbInitError = getDbInitError();
        if (dbInitError) return { success: false, error: dbInitError.message };

        const db = await getDb();

        await db.update(ingredientsTable)
            .set({ name })
            .where(eq(ingredientsTable.id, id));

        return { success: true, id, name };
    }
};