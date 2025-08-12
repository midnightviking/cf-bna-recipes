export async function load({ fetch, params, depends }) {
    const cookbooks = await fetch('/api/cookbooks').then((d) => d.json());
    depends('cookbooks');
    return {
        cookbooks: cookbooks
    }
}


