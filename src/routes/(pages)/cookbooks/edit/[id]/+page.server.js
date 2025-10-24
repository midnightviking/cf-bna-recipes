export async function load({ fetch, params, depends }) {
	try {
		const id = params.id;

		// Fetch cookbook
		const cookbookResponse = await fetch(`/api/cookbooks/${id}`);
		if (!cookbookResponse.ok) {
			if (cookbookResponse.status === 404) {
				throw {
					status: 404,
					message: `Cookbook with ID ${id} not found`,
				};
			}
			throw new Error(`Failed to load cookbook: ${cookbookResponse.statusText}`);
		}

		const cookbook = await cookbookResponse.json();
		if (!cookbook) {
			throw {
				status: 404,
				message: 'Cookbook not found',
			};
		}

		// Fetch recipes
		let recipes = [];
		try {
			const recipesResponse = await fetch('/api/recipes', { cache: 'no-store' });
			if (recipesResponse.ok) {
				recipes = await recipesResponse.json();
			} else {
				console.warn('Failed to fetch recipes');
			}
		} catch (error) {
			console.error('Error fetching recipes:', error);
		}

		return {
			cookbook,
			recipes,
		};
	} catch (error) {
		const message = error.message || 'Failed to load cookbook';
		const status = error.status || 500;

		// Return error state for client to handle
		return {
			cookbook: null,
			recipes: [],
			error: message,
			status,
		};
	}
}


