import { extensions } from '$lib/server/db/schema';
import { error } from '@sveltejs/kit';
/** @type {import('./$types').PageServerLoad} */
export async function load({ fetch, params }) {
    
    const res = await fetch(`/api/recipes/${params.id}`, { cache: "no-store" });
    if (!res.ok) throw error(res.status, 'Recipe not found');
    const recipe = await res.json();
    const all_ingredients = await fetch('/api/ingredients').then((d) => d.json());
    const units = await fetch('/api/units').then((d) => d.json());
    const extensions = await fetch('/api/extensions').then((d) => d.json());
    return {
        recipe,
        all_ingredients,
        units,
        extensions
    };
}


