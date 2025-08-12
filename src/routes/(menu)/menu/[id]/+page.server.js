export async function load({ fetch, params, depends }) {    
    
    const id = params.id;
    return {
        units: await fetch('/api/units').then((d) => d.json()),
        cookbook: await fetch(`/api/cookbooks/${id}`).then((d) => d.json()),
        extensions: await fetch('/api/extensions').then((d) => d.json())
    }
}


