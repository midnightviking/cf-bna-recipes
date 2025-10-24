/**
 * API helper utilities with error handling
 */

/**
 * Make an API call with error handling
 * @param {string} url - API endpoint URL
 * @param {Object} options - Fetch options
 * @returns {Promise<Object>} - { success: boolean, data: any, error: string|null }
 */
async function apiCall(url, options = {}) {
	try {
		const response = await fetch(url, {
			...options,
			headers: {
				'Content-Type': 'application/json',
				...options.headers,
			},
		});

		const data = await response.json();

		if (!response.ok) {
			return {
				success: false,
				data: null,
				error: data.error || `HTTP ${response.status}: ${response.statusText}`,
			};
		}

		return {
			success: true,
			data,
			error: null,
		};
	} catch (error) {
		return {
			success: false,
			data: null,
			error: error.message || 'Unknown error occurred',
		};
	}
}

/**
 * Get a cookbook by ID
 * @param {number} id - Cookbook ID
 * @returns {Promise<Object>} - { success: boolean, data: cookbook, error: string|null }
 */
export async function getCookbook(id) {
	return apiCall(`/api/cookbooks/${id}`);
}

/**
 * Save a cookbook (create or update)
 * @param {Object} cookbook - Cookbook data
 * @param {boolean} isEdit - Whether this is an update operation
 * @returns {Promise<Object>} - { success: boolean, data: any, error: string|null }
 */
export async function saveCookbook(cookbook, isEdit = false) {
	const method = isEdit ? 'PUT' : 'POST';
	return apiCall('/api/cookbooks', {
		method,
		body: JSON.stringify(cookbook),
	});
}

/**
 * Delete a cookbook
 * @param {number} id - Cookbook ID
 * @returns {Promise<Object>} - { success: boolean, data: any, error: string|null }
 */
export async function deleteCookbook(id) {
	return apiCall(`/api/cookbooks/${id}`, {
		method: 'DELETE',
	});
}

/**
 * Get all recipes
 * @returns {Promise<Object>} - { success: boolean, data: recipes, error: string|null }
 */
export async function getAllRecipes() {
	return apiCall('/api/recipes', {
		cache: 'no-store',
	});
}

/**
 * Format cookbook for API submission
 * @param {Object} formData - Form data
 * @param {number|null} id - Cookbook ID (null for new)
 * @returns {Object} - Formatted cookbook object
 */
export function formatCookbookForApi(formData, id = null) {
	return {
		...(id && { id }),
		name: formData.name?.trim(),
		description: formData.description?.trim(),
		recipes: (formData.selectedRecipeIds || []).map((recipeId, idx) => ({
			id: recipeId,
			ordering: idx,
		})),
	};
}
