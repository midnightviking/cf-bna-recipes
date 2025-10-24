/** @type {import('./$types').PageServerLoad} */
export async function load({ fetch, params, depends }) {
    depends('app:recipes');
    
    try {
        const recipesResponse = await fetch('/api/recipes', { cache: "no-store" });
        const recipes = await recipesResponse.json();
        
        const ingredientsResponse = await fetch('/api/ingredients');
        const ingredients = await ingredientsResponse.json();
        
        const unitsResponse = await fetch('/api/units');
        const units = await unitsResponse.json();
        
        return {
            recipes: Array.isArray(recipes) ? recipes : [],
            ingredients: Array.isArray(ingredients) ? ingredients : [],
            units: Array.isArray(units) ? units : [],
            error: recipes?.error || ingredients?.error || units?.error || null
        };
    } catch (error) {
        console.error('Error loading recipes page:', error);
        return {
            recipes: [],
            ingredients: [],
            units: [],
            error: error.message || 'Failed to load data'
        };
    }
}


