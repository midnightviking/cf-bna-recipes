import { writable, derived, get } from 'svelte/store';
import { validateRecipeStructure, validateIngredient, validateSection } from '../server/validation.js';
import { fetchJson, formatApiError } from '../services/api-client.js';

/**
 * Centralized recipe store
 * Single source of truth for all recipe-related state
 * No prop drilling, all mutations validated
 */

// Initialize store with blank recipe shape
const createRecipeStore = () => {
	const initialRecipe = {
		id: null,
		title: '',
		minTemp: '',
		itemType: '',
		portionSize: '',
		calories: '',
		protein: '',
		category: '',
		instructions: '',
		ccp: '',
		substitutions: '',
		initialServings: 100,
	};

	const initialIngredients = [];
	const initialSections = [];
	const initialAlternates = [];

	// Core stores
	const recipe = writable(initialRecipe);
	const ingredients = writable(initialIngredients);
	const sections = writable(initialSections);
	const alternates = writable(initialAlternates);

	// Track if we have unsaved changes
	let savedState = JSON.stringify({ ...initialRecipe, ingredients: initialIngredients, sections: initialSections, alternates: initialAlternates });

	// Derived: formatted sections with ingredients assigned
	const sectionsByIngredient = derived(
		[sections, ingredients],
		([$sections, $ingredients]) => {
			const sectionMap = new Map();
			
			// Add default section
			sectionMap.set(-1, {
				ordering: -1,
				name: 'Default',
				id: -1,
				ingredients: [],
			});

			// Add real sections (saved with positive IDs or temporary negative IDs)
			$sections.forEach((sec) => {
				sectionMap.set(sec.id, {
					...sec,
					ordering: sec.ordering ?? 0,
					ingredients: [],
				});
			});

			// Assign ingredients to sections
			$ingredients.forEach((ing) => {
				// If ingredient has a section_id, try to place it there (handles both positive and negative IDs)
				let sectionId = -1; // default
				if (ing.section_id && sectionMap.has(ing.section_id)) {
					sectionId = ing.section_id;
				} else if (ing.section_id && ing.section_id > 0) {
					// Positive section_id but not in map yet - should go to default
					sectionId = -1;
				} else if (!ing.section_id || ing.section_id === -1) {
					sectionId = -1;
				}
				
				sectionMap.get(sectionId).ingredients.push(ing);
			});

			return Array.from(sectionMap.values());
		}
	);

	// Derived: validation status (only for saved recipes, not in-progress)
	const validationStatus = derived(
		[recipe, ingredients, sections, alternates],
		([$recipe, $ingredients, $sections, $alternates]) => {
			// Only validate if recipe has a title (basic check)
			if (!$recipe.title || $recipe.title.trim() === '') {
				return {
					valid: false,
					errors: { title: ['Recipe title is required'] }
				};
			}
			return {
				valid: true,
				errors: {}
			};
		}
	);

	// Derived: is valid
	const isValid = derived(
		validationStatus,
		($status) => $status.valid
	);

	// Derived: has unsaved changes
	const hasChanges = derived(
		[recipe, ingredients, sections, alternates],
		([$recipe, $ingredients, $sections, $alternates]) => {
			const currentState = JSON.stringify({ ...$recipe, ingredients: $ingredients, sections: $sections, alternates: $alternates });
			return currentState !== savedState;
		}
	);

	// Methods
	const methods = {
		/**
		 * Get current state snapshot
		 */
		getState() {
			return {
				recipe: get(recipe),
				ingredients: get(ingredients),
				sections: get(sections),
				alternates: get(alternates),
			};
		},

		/**
		 * Update recipe metadata (title, servings, etc)
		 */
		updateRecipe(updates) {
			recipe.update(r => ({ ...r, ...updates }));
		},

		/**
		 * Replace entire recipe
		 */
		setRecipe(newRecipe) {
			recipe.set(newRecipe);
		},

	/**
	 * Add ingredient to list
	 * @param {Object} ingredient - must have ingredient_id, quantity, unit_id
	 */
	addIngredient(ingredient) {
		// Validate without negative section_id (temporary for new sections)
		const validationPayload = {
			...ingredient,
			section_id: ingredient.section_id && ingredient.section_id > 0 ? ingredient.section_id : null,
		};
		
		const validation = validateIngredient(validationPayload);
		if (!validation.valid) {
			throw new Error(`Invalid ingredient: ${JSON.stringify(validation.errors)}`);
		}

		const nextLocalIndex = Math.max(
			-1,
			...get(ingredients).map(i => i._localIndex ?? 0)
		) + 1;

		const newIngredient = {
			id: null,
			...ingredient, // Keep original section_id (may be negative for new sections)
			_localIndex: nextLocalIndex,
			ordering: get(ingredients).length,
		};

		ingredients.update(list => [...list, newIngredient]);
	},		/**
		 * Update ingredient by id
		 */
		updateIngredient(id, updates) {
			ingredients.update(list =>
				list.map(ing =>
					ing.id === id || ing._localIndex === id
						? { ...ing, ...updates }
						: ing
				)
			);
		},

		/**
		 * Delete ingredient by id and reorder
		 */
		deleteIngredient(id) {
			ingredients.update(list => {
				const filtered = list.filter(ing => ing.id !== id && ing._localIndex !== id);
				return filtered.map((ing, idx) => ({ ...ing, ordering: idx }));
			});
		},

		/**
		 * Add section
		 */
		addSection(section) {
			const validation = validateSection(section);
			if (!validation.valid) {
				throw new Error(`Invalid section: ${JSON.stringify(validation.errors)}`);
			}

			const maxId = Math.min(
				-2,
				...get(sections).map(s => s.id ?? 0).filter(id => id < 0)
			);
			const nextNegativeId = maxId - 1;

			const newSection = {
				id: nextNegativeId,
				...section,
				ordering: get(sections).length,
			};

			sections.update(list => [...list, newSection]);
			return nextNegativeId;
		},

		/**
		 * Update section by id
		 */
		updateSection(id, updates) {
			sections.update(list =>
				list.map(sec => sec.id === id ? { ...sec, ...updates } : sec)
			);
		},

		/**
		 * Delete section by id and reorder
		 */
		deleteSection(id) {
			// Move ingredients from deleted section to default (-1)
			ingredients.update(list =>
				list.map(ing =>
					ing.section_id === id ? { ...ing, section_id: -1 } : ing
				)
			);

			// Remove section and reorder
			sections.update(list => {
				const filtered = list.filter(sec => sec.id !== id);
				return filtered.map((sec, idx) => ({ ...sec, ordering: idx }));
			});
		},

	/**
	 * Add alternate ingredient
	 */
	addAlternate(alternate) {
		if (!alternate.alternate_ingredient || !alternate.quantity || !alternate.unit_id) {
			throw new Error('Invalid alternate: missing required fields');
		}

		const id = Math.max(-1, ...get(alternates).map(a => a.id ?? 0)) + 1;

		const newAlternate = {
			id,
			...alternate,
		};

		alternates.update(list => [...list, newAlternate]);
		return id;
	},

	/**
	 * Update alternate by id
	 */
	updateAlternate(id, updates) {
		alternates.update(list =>
			list.map(alt => alt.id === id ? { ...alt, ...updates } : alt)
		);
	},

	/**
	 * Delete alternate by id
	 */
	deleteAlternate(id) {
		alternates.update(list => list.filter(alt => alt.id !== id));
	},		/**
		 * Load recipe from API by id
		 */
		async load(recipeId) {
			try {
				const data = await fetchJson(`/api/recipes/${recipeId}`);
				const recipeData = data[0]; // API returns array

				recipe.set({
					id: recipeData.id,
					title: recipeData.title ?? '',
					minTemp: recipeData.minTemp ?? '',
					itemType: recipeData.itemType ?? '',
					portionSize: recipeData.portionSize ?? '',
					calories: recipeData.calories ?? '',
					protein: recipeData.protein ?? '',
					category: recipeData.category ?? '',
					instructions: recipeData.instructions ?? '',
					ccp: recipeData.ccp ?? '',
					substitutions: recipeData.substitutions ?? '',
					initialServings: recipeData.initialServings ?? 100,
				});

				// Load ingredients with proper mapping
				const ing = (recipeData.ingredients ?? []).map((i, idx) => ({
					id: i.id,
					ingredient_id: i.ingredient_id,
					quantity: i.quantity,
					unit_id: i.unit_id,
					ordering: i.ordering ?? idx,
					section_id: i.section_id,
					_localIndex: idx,
				}));
				ingredients.set(ing);

				// Load sections
				const sec = (recipeData.sections ?? []).map((s, idx) => ({
					id: s.id,
					name: s.name,
					ordering: s.ordering ?? idx,
				}));
				sections.set(sec);

				// Load alternates
				alternates.set(recipeData.alternates ?? []);

				// Reset change tracking
				savedState = JSON.stringify({
					...get(recipe),
					ingredients: ing,
					sections: sec,
					alternates: get(alternates),
				});
			} catch (error) {
				throw new Error(`Failed to load recipe: ${formatApiError(error)}`);
			}
		},

		/**
		 * Save recipe to API (POST for new, PUT for existing)
		 */
		async save() {
			const $recipe = get(recipe);
			const $ingredients = get(ingredients);
			const $sections = get(sections);
			const $alternates = get(alternates);

			// Validate before saving
			const validation = validateRecipeStructure({
				...$recipe,
				ingredients: $ingredients,
				sections: $sections,
				alternates: $alternates,
			});

			if (!validation.valid) {
				throw new Error(`Validation failed: ${JSON.stringify(validation.errors)}`);
			}

			// Prepare payload
			const payload = {
				id: $recipe.id,
				title: $recipe.title,
				minTemp: $recipe.minTemp,
				itemType: $recipe.itemType,
				portionSize: $recipe.portionSize,
				calories: $recipe.calories,
				protein: $recipe.protein,
				category: $recipe.category,
				instructions: $recipe.instructions,
				ccp: $recipe.ccp,
				substitutions: $recipe.substitutions,
				initialServings: $recipe.initialServings,
				ingredients: $ingredients.map(i => ({
					id: i.id,
					ingredient_id: i.ingredient_id,
					quantity: i.quantity,
					unit_id: i.unit_id,
					ordering: i.ordering,
					section_id: (i.section_id && i.section_id > 0) ? i.section_id : null,
				})),
				sections: $sections
					.filter(s => s.id !== -1) // Exclude default section
					.map(s => ({
						id: s.id > 0 ? s.id : undefined,
						name: s.name,
						ordering: s.ordering,
					})),
				alternates: $alternates.map(a => ({ ...a })),
			};

			try {
				const method = $recipe.id ? 'PUT' : 'POST';
				const result = await fetchJson('/api/recipes', {
					method,
					headers: { 'Content-Type': 'application/json' },
					body: JSON.stringify(payload),
				});

				// Update recipe id if new
				if (!$recipe.id && result.id) {
					recipe.update(r => ({ ...r, id: result.id }));
				}

				// Reset change tracking
				savedState = JSON.stringify({
					...$recipe,
					ingredients: $ingredients,
					sections: $sections,
					alternates: $alternates,
				});

				return result;
			} catch (error) {
				throw new Error(`Failed to save recipe: ${formatApiError(error)}`);
			}
		},

		/**
		 * Clear all state
		 */
		reset() {
			recipe.set(initialRecipe);
			ingredients.set(initialIngredients);
			sections.set(initialSections);
			alternates.set(initialAlternates);
			savedState = JSON.stringify({
				...initialRecipe,
				ingredients: initialIngredients,
				sections: initialSections,
				alternates: initialAlternates,
			});
		},

		/**
		 * Create new blank recipe
		 */
		blank() {
			recipe.set(initialRecipe);
			ingredients.set([]);
			sections.set([]);
			alternates.set([]);
			savedState = JSON.stringify({
				...initialRecipe,
				ingredients: [],
				sections: [],
				alternates: [],
			});
		},

		/**
		 * Get validation errors (if any)
		 */
		getErrors() {
			const status = get(validationStatus);
			return status.valid ? null : (status.errors || {});
		},
	};

	return {
		// Stores
		recipe,
		ingredients,
		sections,
		alternates,
		sectionsByIngredient,
		isValid,
		hasChanges,
		validationStatus,

		// Methods
		...methods,
	};
};

// Export singleton instance
export const recipeStore = createRecipeStore();
