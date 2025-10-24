/**
 * Validation utilities for cookbook forms
 */

/**
 * Validate cookbook name
 * @param {string} name - Cookbook name to validate
 * @returns {Object} - { isValid: boolean, error: string|null }
 */
export function validateCookbookName(name) {
	if (!name || typeof name !== 'string') {
		return { isValid: false, error: 'Cookbook name is required' };
	}

	const trimmed = name.trim();
	if (trimmed.length === 0) {
		return { isValid: false, error: 'Cookbook name cannot be empty' };
	}

	if (trimmed.length > 100) {
		return { isValid: false, error: 'Cookbook name must be 100 characters or less' };
	}

	if (trimmed.length < 2) {
		return { isValid: false, error: 'Cookbook name must be at least 2 characters' };
	}

	return { isValid: true, error: null };
}

/**
 * Validate cookbook description
 * @param {string} description - Cookbook description to validate
 * @returns {Object} - { isValid: boolean, error: string|null }
 */
export function validateCookbookDescription(description) {
	if (!description || typeof description !== 'string') {
		return { isValid: true, error: null }; // Optional field
	}

	if (description.length > 500) {
		return { isValid: false, error: 'Description must be 500 characters or less' };
	}

	return { isValid: true, error: null };
}

/**
 * Validate recipe selection
 * @param {number[]} selectedRecipeIds - Selected recipe IDs
 * @param {Object[]} allRecipes - All available recipes
 * @returns {Object} - { isValid: boolean, error: string|null }
 */
export function validateRecipeSelection(selectedRecipeIds, allRecipes) {
	if (!Array.isArray(selectedRecipeIds)) {
		return { isValid: false, error: 'Invalid recipe selection' };
	}

	// Check for invalid IDs (not in all_recipes)
	const invalidIds = selectedRecipeIds.filter(
		(id) => !allRecipes.some((r) => r?.id === id)
	);

	if (invalidIds.length > 0) {
		return { isValid: false, error: `Invalid recipe IDs: ${invalidIds.join(', ')}` };
	}

	return { isValid: true, error: null };
}

/**
 * Validate complete cookbook form
 * @param {Object} cookbook - Cookbook object with name, description, recipeIds
 * @param {Object[]} allRecipes - All available recipes
 * @returns {Object} - { isValid: boolean, errors: Object }
 */
export function validateCookbook(cookbook, allRecipes = []) {
	const errors = {};

	const nameValidation = validateCookbookName(cookbook.name);
	if (!nameValidation.isValid) {
		errors.name = nameValidation.error;
	}

	const descValidation = validateCookbookDescription(cookbook.description);
	if (!descValidation.isValid) {
		errors.description = descValidation.error;
	}

	const recipeValidation = validateRecipeSelection(cookbook.recipes || [], allRecipes);
	if (!recipeValidation.isValid) {
		errors.recipes = recipeValidation.error;
	}

	return {
		isValid: Object.keys(errors).length === 0,
		errors,
	};
}
