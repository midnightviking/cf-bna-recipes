/** @type {import('./$types').PageLoad} */
export async function load({ fetch, params }) {
	return{
		all_units: await fetch('/api/units').then((d) => d.json())
	}
}

