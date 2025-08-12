export async function load({ fetch, params, depends }) {
    const cookbook = await fetch('/api/cookbooks/' + params.id).then((d) => d.json());
    const recipes = await fetch('/api/recipes', { cache: "no-store" }).then((d) => d.json());
    const ingredients = await fetch('/api/ingredients').then((d) => d.json());
    const units = await fetch('/api/units').then((d) => d.json());
    return {
        cookbook: cookbook,
        recipes: recipes,
        ingredients: ingredients,
        units: units
    }
}


