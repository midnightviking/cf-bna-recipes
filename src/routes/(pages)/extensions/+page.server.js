export async function load({ fetch, params }) {
    return {
        extensions: await fetch('/api/extensions').then((d) => d.json())
    };
};

import { getDb, getDbInitError } from '$lib/server/db';
import { extensions } from '$lib/server/db/schema.js';
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

        await db.update(extensions)
            .set({ name })
            .where(eq(extensions.id, id));

        return { success: true, id, name };
    },
    add: async ({ request }) => {
        const data = await request.formData();
        const name = data.get("name");

        const dbInitError = getDbInitError();
        if (dbInitError) return { success: false, error: dbInitError.message };

        const db = await getDb();

        const [inserted] = await db.insert(extensions).values({ name }).returning();
        return { success: true, id: inserted.id, name: inserted.name };
    }
};