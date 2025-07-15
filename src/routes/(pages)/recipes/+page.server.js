/** @type {import('./$types').PageServerLoad} */
export async function load({ fetch, params, depends }) {
    depends('app:recipes');
    const recipes = await fetch('/api/recipes', { cache: "no-store" }).then((d) => d.json());
    const ingredients = await fetch('/api/ingredients').then((d) => d.json());
    const units = await fetch('/api/units').then((d) => d.json());
    return {
        recipes: recipes,
        ingredients: ingredients,
        units: units
    }
}


