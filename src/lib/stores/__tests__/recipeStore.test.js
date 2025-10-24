import { describe, it, expect, beforeEach } from 'vitest';
import { get } from 'svelte/store';
import { recipeStore } from '../recipeStore.js';

describe('Recipe Store', () => {
	beforeEach(() => {
		recipeStore.reset();
	});

	describe('Initial State', () => {
		it('starts with blank recipe', () => {
			const recipe = get(recipeStore.recipe);
			expect(recipe.title).toBe('');
			expect(recipe.initialServings).toBe(100);
		});

		it('starts with empty ingredients', () => {
			const ings = get(recipeStore.ingredients);
			expect(ings).toEqual([]);
		});

		it('starts with empty sections', () => {
			const secs = get(recipeStore.sections);
			expect(secs).toEqual([]);
		});

		it('starts as not modified', () => {
			const hasChanges = get(recipeStore.hasChanges);
			expect(hasChanges).toBe(false);
		});
	});

	describe('Recipe Metadata', () => {
		it('updates recipe title', () => {
			recipeStore.updateRecipe({ title: 'Pasta Carbonara' });
			const recipe = get(recipeStore.recipe);
			expect(recipe.title).toBe('Pasta Carbonara');
		});

		it('updates multiple recipe fields', () => {
			recipeStore.updateRecipe({
				title: 'Pasta',
				category: 'Italian',
				initialServings: 4,
			});
			const recipe = get(recipeStore.recipe);
			expect(recipe.title).toBe('Pasta');
			expect(recipe.category).toBe('Italian');
			expect(recipe.initialServings).toBe(4);
		});

		it('replaces entire recipe', () => {
			const newRecipe = {
				id: 1,
				title: 'New Recipe',
				minTemp: '',
				itemType: '',
				portionSize: '',
				calories: '',
				protein: '',
				category: '',
				instructions: '',
				ccp: '',
				substitutions: '',
				initialServings: 50,
			};
			recipeStore.setRecipe(newRecipe);
			const recipe = get(recipeStore.recipe);
			expect(recipe.id).toBe(1);
			expect(recipe.title).toBe('New Recipe');
			expect(recipe.initialServings).toBe(50);
		});

		it('tracks changes after update', () => {
			recipeStore.updateRecipe({ title: 'Changed' });
			const hasChanges = get(recipeStore.hasChanges);
			expect(hasChanges).toBe(true);
		});
	});

	describe('Ingredients', () => {
		it('adds valid ingredient', () => {
			recipeStore.addIngredient({
				ingredient_id: 1,
				quantity: 200,
				unit_id: 5,
			});
			const ings = get(recipeStore.ingredients);
			expect(ings).toHaveLength(1);
			expect(ings[0].ingredient_id).toBe(1);
			expect(ings[0].quantity).toBe(200);
		});

		it('rejects ingredient with missing ingredient_id', () => {
			expect(() => {
				recipeStore.addIngredient({
					quantity: 200,
					unit_id: 5,
				});
			}).toThrow();
		});

		it('rejects ingredient with zero quantity', () => {
			expect(() => {
				recipeStore.addIngredient({
					ingredient_id: 1,
					quantity: 0,
					unit_id: 5,
				});
			}).toThrow();
		});

		it('rejects ingredient with negative quantity', () => {
			expect(() => {
				recipeStore.addIngredient({
					ingredient_id: 1,
					quantity: -10,
					unit_id: 5,
				});
			}).toThrow();
		});

		it('adds multiple ingredients', () => {
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });
			recipeStore.addIngredient({ ingredient_id: 2, quantity: 200, unit_id: 2 });
			const ings = get(recipeStore.ingredients);
			expect(ings).toHaveLength(2);
		});

		it('updates ingredient', () => {
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });
			const ing = get(recipeStore.ingredients)[0];
			recipeStore.updateIngredient(ing._localIndex, { quantity: 150 });
			const updated = get(recipeStore.ingredients)[0];
			expect(updated.quantity).toBe(150);
		});

		it('deletes ingredient', () => {
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });
			recipeStore.addIngredient({ ingredient_id: 2, quantity: 200, unit_id: 2 });
			const ing = get(recipeStore.ingredients)[0];
			recipeStore.deleteIngredient(ing._localIndex);
			const remaining = get(recipeStore.ingredients);
			expect(remaining).toHaveLength(1);
			expect(remaining[0].ingredient_id).toBe(2);
		});

		it('reorders ingredients after deletion', () => {
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });
			recipeStore.addIngredient({ ingredient_id: 2, quantity: 200, unit_id: 2 });
			recipeStore.addIngredient({ ingredient_id: 3, quantity: 300, unit_id: 3 });

			const first = get(recipeStore.ingredients)[0];
			recipeStore.deleteIngredient(first._localIndex);

			const ings = get(recipeStore.ingredients);
			expect(ings[0].ordering).toBe(0);
			expect(ings[1].ordering).toBe(1);
		});

		it('assigns section_id to ingredient', () => {
			recipeStore.addIngredient({
				ingredient_id: 1,
				quantity: 100,
				unit_id: 1,
				section_id: 5,
			});
			const ing = get(recipeStore.ingredients)[0];
			expect(ing.section_id).toBe(5);
		});
	});

	describe('Sections', () => {
		it('adds valid section', () => {
			recipeStore.addSection({ name: 'Prep' });
			const secs = get(recipeStore.sections);
			expect(secs).toHaveLength(1);
			expect(secs[0].name).toBe('Prep');
		});

		it('rejects section without name', () => {
			expect(() => {
				recipeStore.addSection({ name: '' });
			}).toThrow();
		});

		it('adds multiple sections', () => {
			recipeStore.addSection({ name: 'Prep' });
			recipeStore.addSection({ name: 'Cook' });
			const secs = get(recipeStore.sections);
			expect(secs).toHaveLength(2);
		});

		it('updates section', () => {
			const id = recipeStore.addSection({ name: 'Prep' });
			recipeStore.updateSection(id, { name: 'Preparation' });
			const sec = get(recipeStore.sections)[0];
			expect(sec.name).toBe('Preparation');
		});

		it('deletes section', () => {
			const id = recipeStore.addSection({ name: 'Prep' });
			recipeStore.addSection({ name: 'Cook' });
			recipeStore.deleteSection(id);
			const secs = get(recipeStore.sections);
			expect(secs).toHaveLength(1);
			expect(secs[0].name).toBe('Cook');
		});

		it('reassigns ingredients when section deleted', () => {
			const secId = recipeStore.addSection({ name: 'Prep' });
			recipeStore.addIngredient({
				ingredient_id: 1,
				quantity: 100,
				unit_id: 1,
				section_id: secId,
			});

			recipeStore.deleteSection(secId);

			const ing = get(recipeStore.ingredients)[0];
			expect(ing.section_id).toBe(-1); // Default section
		});

		it('reorders sections after deletion', () => {
			const id1 = recipeStore.addSection({ name: 'First' });
			const id2 = recipeStore.addSection({ name: 'Second' });
			const id3 = recipeStore.addSection({ name: 'Third' });

			recipeStore.deleteSection(id1);

			const secs = get(recipeStore.sections);
			expect(secs[0].ordering).toBe(0);
			expect(secs[1].ordering).toBe(1);
		});
	});

	describe('Alternates', () => {
		it('adds valid alternate', () => {
			recipeStore.addAlternate({
				alternate_ingredient: 10,
				quantity: 50,
				unit_id: 3,
			});
			const alts = get(recipeStore.alternates);
			expect(alts).toHaveLength(1);
			expect(alts[0].alternate_ingredient).toBe(10);
		});

		it('rejects alternate without quantity', () => {
			expect(() => {
				recipeStore.addAlternate({
					alternate_ingredient: 10,
					unit_id: 3,
				});
			}).toThrow();
		});

		it('updates alternate', () => {
			recipeStore.addAlternate({
				alternate_ingredient: 10,
				quantity: 50,
				unit_id: 3,
			});
			const alt = get(recipeStore.alternates)[0];
			recipeStore.updateAlternate(alt.id, { quantity: 75 });
			const updated = get(recipeStore.alternates)[0];
			expect(updated.quantity).toBe(75);
		});

		it('deletes alternate', () => {
			recipeStore.addAlternate({ alternate_ingredient: 10, quantity: 50, unit_id: 3 });
			recipeStore.addAlternate({ alternate_ingredient: 11, quantity: 60, unit_id: 3 });
			const alt = get(recipeStore.alternates)[0];
			recipeStore.deleteAlternate(alt.id);
			const remaining = get(recipeStore.alternates);
			expect(remaining).toHaveLength(1);
			expect(remaining[0].alternate_ingredient).toBe(11);
		});
	});

	describe('Derived Stores', () => {
		it('computes sectionsByIngredient', () => {
			recipeStore.addSection({ name: 'Prep' });
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });

			const sections = get(recipeStore.sectionsByIngredient);
			expect(sections).toHaveLength(2); // Default + Prep
			expect(sections[0].name).toBe('Default');
			expect(sections[1].name).toBe('Prep');
		});

		it('assigns ingredients to correct sections', () => {
			const secId = recipeStore.addSection({ name: 'Toppings' });
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });
			recipeStore.addIngredient({
				ingredient_id: 2,
				quantity: 50,
				unit_id: 1,
				section_id: secId,
			});

			const sections = get(recipeStore.sectionsByIngredient);
			const defaultSec = sections.find(s => s.id === -1);
			const toppingsSec = sections.find(s => s.name === 'Toppings');

			expect(defaultSec.ingredients).toHaveLength(1);
			expect(toppingsSec.ingredients).toHaveLength(1);
		});

		it('validates recipe structure', () => {
			recipeStore.updateRecipe({ title: '' });
			const valid = get(recipeStore.isValid);
			expect(valid).toBe(false);
		});

		it('is valid when title present', () => {
			recipeStore.updateRecipe({ title: 'Valid Recipe' });
			const valid = get(recipeStore.isValid);
			expect(valid).toBe(true);
		});

		it('tracks unsaved changes', () => {
			expect(get(recipeStore.hasChanges)).toBe(false);
			recipeStore.updateRecipe({ title: 'Modified' });
			expect(get(recipeStore.hasChanges)).toBe(true);
		});
	});

	describe('Getters', () => {
		it('returns state snapshot', () => {
			recipeStore.updateRecipe({ title: 'Test' });
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });

			const state = recipeStore.getState();
			expect(state.recipe.title).toBe('Test');
			expect(state.ingredients).toHaveLength(1);
		});

		it('returns validation errors', () => {
			recipeStore.updateRecipe({ title: '' });
			const errors = recipeStore.getErrors();
			expect(errors).not.toBeNull();
			expect(errors.title).toBeDefined();
		});

		it('returns null when valid', () => {
			recipeStore.updateRecipe({ title: 'Valid' });
			const errors = recipeStore.getErrors();
			expect(errors).toBeNull();
		});
	});

	describe('Lifecycle', () => {
		it('resets to initial state', () => {
			recipeStore.updateRecipe({ title: 'Test' });
			recipeStore.addIngredient({ ingredient_id: 1, quantity: 100, unit_id: 1 });
			recipeStore.addSection({ name: 'Prep' });

			recipeStore.reset();

			const state = recipeStore.getState();
			expect(state.recipe.title).toBe('');
			expect(state.ingredients).toHaveLength(0);
			expect(state.sections).toHaveLength(0);
		});

		it('clears changes tracking after reset', () => {
			recipeStore.updateRecipe({ title: 'Changed' });
			recipeStore.reset();
			expect(get(recipeStore.hasChanges)).toBe(false);
		});

		it('creates blank recipe state', () => {
			recipeStore.updateRecipe({ title: 'Old' });
			recipeStore.blank();
			const recipe = get(recipeStore.recipe);
			expect(recipe.title).toBe('');
			expect(recipe.initialServings).toBe(100);
		});
	});

	describe('Complex Scenarios', () => {
		it('manages complete recipe workflow', () => {
			// Create recipe
			recipeStore.updateRecipe({
				title: 'Pasta Carbonara',
				category: 'Italian',
				initialServings: 4,
			});

			// Add sections
			const prep = recipeStore.addSection({ name: 'Prep' });
			const cook = recipeStore.addSection({ name: 'Cook' });

			// Add ingredients to sections
			recipeStore.addIngredient({
				ingredient_id: 1,
				quantity: 400,
				unit_id: 1,
				section_id: prep,
			});
			recipeStore.addIngredient({
				ingredient_id: 2,
				quantity: 200,
				unit_id: 2,
				section_id: cook,
			});

			// Add alternates
			recipeStore.addAlternate({
				alternate_ingredient: 3,
				quantity: 150,
				unit_id: 1,
			});

			// Verify
			const state = recipeStore.getState();
			expect(state.recipe.title).toBe('Pasta Carbonara');
			expect(state.ingredients).toHaveLength(2);
			expect(state.sections).toHaveLength(2);
			expect(state.alternates).toHaveLength(1);
			expect(get(recipeStore.isValid)).toBe(true);
			expect(get(recipeStore.hasChanges)).toBe(true);
		});

		it('handles section and ingredient organization', () => {
			const sec1 = recipeStore.addSection({ name: 'A' });
			const sec2 = recipeStore.addSection({ name: 'B' });

			recipeStore.addIngredient({
				ingredient_id: 1,
				quantity: 100,
				unit_id: 1,
				section_id: sec1,
			});
			recipeStore.addIngredient({
				ingredient_id: 2,
				quantity: 200,
				unit_id: 1,
				section_id: sec2,
			});
			recipeStore.addIngredient({
				ingredient_id: 3,
				quantity: 300,
				unit_id: 1,
			});

			const sections = get(recipeStore.sectionsByIngredient);
			const defaultSection = sections.find(s => s.id === -1);
			const sectionA = sections.find(s => s.name === 'A');
			const sectionB = sections.find(s => s.name === 'B');

			expect(defaultSection.ingredients).toHaveLength(1);
			expect(sectionA.ingredients).toHaveLength(1);
			expect(sectionB.ingredients).toHaveLength(1);
		});
	});
});
