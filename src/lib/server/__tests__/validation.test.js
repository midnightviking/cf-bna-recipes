/**
 * Tests for validation.js
 * 
 * Run with: npm test -- validation.test.js
 */

import { describe, it, expect } from 'vitest';
import {
  validateRecipe,
  validateIngredient,
  validateSection,
  validateAlternate,
  validateRecipeStructure,
  validateRecipeId
} from '../validation.js';

describe('Recipe Validation', () => {
  describe('validateRecipe', () => {
    it('accepts valid recipe with required fields only', () => {
      const result = validateRecipe({
        title: 'Chicken Soup'
      });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });

    it('accepts valid recipe with all fields', () => {
      const result = validateRecipe({
        title: 'Chicken Soup',
        minTemp: '165°F',
        itemType: 'soup',
        portionSize: '4 servings',
        calories: '150',
        protein: '25g',
        category: 'soups',
        instructions: 'Boil and serve',
        ccp: 'Internal temp 165°F',
        substitutions: 'Can use vegetable broth',
        initialServings: 10
      });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });

    it('rejects recipe without title', () => {
      const result = validateRecipe({});
      expect(result.valid).toBe(false);
      expect(result.errors.title).toBeDefined();
    });

    it('rejects recipe with empty title', () => {
      const result = validateRecipe({ title: '   ' });
      expect(result.valid).toBe(false);
      expect(result.errors.title).toBeDefined();
    });

    it('rejects recipe with non-string title', () => {
      const result = validateRecipe({ title: 123 });
      expect(result.valid).toBe(false);
      expect(result.errors.title).toBeDefined();
    });

    it('rejects recipe with zero servings', () => {
      const result = validateRecipe({
        title: 'Test',
        initialServings: 0
      });
      expect(result.valid).toBe(false);
      expect(result.errors.initialServings).toBeDefined();
    });

    it('rejects recipe with negative servings', () => {
      const result = validateRecipe({
        title: 'Test',
        initialServings: -1
      });
      expect(result.valid).toBe(false);
      expect(result.errors.initialServings).toBeDefined();
    });

    it('rejects recipe with non-numeric servings', () => {
      const result = validateRecipe({
        title: 'Test',
        initialServings: 'four'
      });
      expect(result.valid).toBe(false);
      expect(result.errors.initialServings).toBeDefined();
    });

    it('rejects recipe with non-string optional fields', () => {
      const result = validateRecipe({
        title: 'Test',
        category: 123
      });
      expect(result.valid).toBe(false);
      expect(result.errors.category).toBeDefined();
    });

    it('rejects null recipe', () => {
      const result = validateRecipe(null);
      expect(result.valid).toBe(false);
      expect(result.errors.recipe).toBeDefined();
    });
  });

  describe('validateIngredient', () => {
    it('accepts valid ingredient', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 2,
        unit_id: 3
      });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });

    it('accepts ingredient with section_id', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 2.5,
        unit_id: 3,
        section_id: 5
      });
      expect(result.valid).toBe(true);
    });

    it('rejects ingredient without ingredient_id', () => {
      const result = validateIngredient({
        quantity: 2,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.ingredient_id).toBeDefined();
    });

    it('rejects ingredient with non-integer ingredient_id', () => {
      const result = validateIngredient({
        ingredient_id: 'chicken',
        quantity: 2,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.ingredient_id).toBeDefined();
    });

    it('rejects ingredient with zero quantity', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 0,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.quantity).toBeDefined();
    });

    it('rejects ingredient with negative quantity', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: -5,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.quantity).toBeDefined();
    });

    it('rejects ingredient without unit_id', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 2
      });
      expect(result.valid).toBe(false);
      expect(result.errors.unit_id).toBeDefined();
    });

    it('rejects ingredient with non-integer unit_id', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 2,
        unit_id: 'cups'
      });
      expect(result.valid).toBe(false);
      expect(result.errors.unit_id).toBeDefined();
    });

    it('accepts null section_id', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 2,
        unit_id: 3,
        section_id: null
      });
      expect(result.valid).toBe(true);
    });

    it('rejects non-integer section_id', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 2,
        unit_id: 3,
        section_id: 'five'
      });
      expect(result.valid).toBe(false);
      expect(result.errors.section_id).toBeDefined();
    });
  });

  describe('validateSection', () => {
    it('accepts valid section', () => {
      const result = validateSection({ name: 'Soup' });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });

    it('accepts section with ordering', () => {
      const result = validateSection({
        name: 'Soup',
        ordering: 0
      });
      expect(result.valid).toBe(true);
    });

    it('rejects section without name', () => {
      const result = validateSection({});
      expect(result.valid).toBe(false);
      expect(result.errors.name).toBeDefined();
    });

    it('rejects section with empty name', () => {
      const result = validateSection({ name: '   ' });
      expect(result.valid).toBe(false);
      expect(result.errors.name).toBeDefined();
    });

    it('rejects section with non-string name', () => {
      const result = validateSection({ name: 123 });
      expect(result.valid).toBe(false);
      expect(result.errors.name).toBeDefined();
    });

    it('rejects section with negative ordering', () => {
      const result = validateSection({
        name: 'Soup',
        ordering: -1
      });
      expect(result.valid).toBe(false);
      expect(result.errors.ordering).toBeDefined();
    });

    it('rejects section with non-integer ordering', () => {
      const result = validateSection({
        name: 'Soup',
        ordering: 'first'
      });
      expect(result.valid).toBe(false);
      expect(result.errors.ordering).toBeDefined();
    });
  });

  describe('validateAlternate', () => {
    it('accepts valid alternate', () => {
      const result = validateAlternate({
        alternate_ingredient: 2,
        quantity: 1,
        unit_id: 3
      });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });

    it('rejects alternate without alternate_ingredient', () => {
      const result = validateAlternate({
        quantity: 1,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.alternate_ingredient).toBeDefined();
    });

    it('rejects alternate with zero quantity', () => {
      const result = validateAlternate({
        alternate_ingredient: 2,
        quantity: 0,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.quantity).toBeDefined();
    });

    it('rejects alternate without unit_id', () => {
      const result = validateAlternate({
        alternate_ingredient: 2,
        quantity: 1
      });
      expect(result.valid).toBe(false);
      expect(result.errors.unit_id).toBeDefined();
    });
  });

  describe('validateRecipeStructure', () => {
    it('validates complete recipe structure', () => {
      const result = validateRecipeStructure({
        title: 'Soup',
        sections: [{ name: 'Base' }],
        ingredients: [
          { ingredient_id: 1, quantity: 2, unit_id: 3 }
        ]
      });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });

    it('collects errors from multiple levels', () => {
      const result = validateRecipeStructure({
        title: '',  // Invalid
        sections: [{ name: '' }],  // Invalid
        ingredients: [{ quantity: -1 }]  // Invalid
      });
      expect(result.valid).toBe(false);
      expect(result.errors.recipe).toBeDefined();
      expect(result.errors.sections).toBeDefined();
      expect(result.errors.ingredients).toBeDefined();
    });

    it('validates multiple ingredients', () => {
      const result = validateRecipeStructure({
        title: 'Soup',
        ingredients: [
          { ingredient_id: 1, quantity: 2, unit_id: 3 },
          { ingredient_id: 2, quantity: -1, unit_id: 3 },  // Invalid
          { ingredient_id: 3, quantity: 1 }  // Invalid: no unit_id
        ]
      });
      expect(result.valid).toBe(false);
      expect(result.errors.ingredients).toBeDefined();
      expect(result.errors.ingredients.length).toBe(2);
      expect(result.errors.ingredients[0].index).toBe(1);
      expect(result.errors.ingredients[1].index).toBe(2);
    });

    it('validates multiple sections', () => {
      const result = validateRecipeStructure({
        title: 'Soup',
        sections: [
          { name: 'Base' },
          { name: '' },  // Invalid
          { name: 'Toppings' }
        ]
      });
      expect(result.valid).toBe(false);
      expect(result.errors.sections).toBeDefined();
      expect(result.errors.sections.length).toBe(1);
      expect(result.errors.sections[0].index).toBe(1);
    });

    it('validates extensions if present', () => {
      const result = validateRecipeStructure({
        title: 'Soup',
        extensions: [1, 2, -1]  // -1 is invalid
      });
      expect(result.valid).toBe(false);
      expect(result.errors.extensions).toBeDefined();
    });

    it('handles missing optional arrays', () => {
      const result = validateRecipeStructure({
        title: 'Soup'
      });
      expect(result.valid).toBe(true);
      expect(result.errors).toEqual({});
    });
  });

  describe('validateRecipeId', () => {
    it('accepts valid positive integer', () => {
      const result = validateRecipeId(1);
      expect(result.valid).toBe(true);
      expect(result.error).toBeNull();
    });

    it('accepts valid ID as string that can be converted', () => {
      const result = validateRecipeId('42');
      expect(result.valid).toBe(true);
    });

    it('rejects ID of 0', () => {
      const result = validateRecipeId(0);
      expect(result.valid).toBe(false);
      expect(result.error).toBeDefined();
    });

    it('rejects negative ID', () => {
      const result = validateRecipeId(-1);
      expect(result.valid).toBe(false);
      expect(result.error).toBeDefined();
    });

    it('rejects null ID', () => {
      const result = validateRecipeId(null);
      expect(result.valid).toBe(false);
      expect(result.error).toBeDefined();
    });

    it('rejects undefined ID', () => {
      const result = validateRecipeId(undefined);
      expect(result.valid).toBe(false);
      expect(result.error).toBeDefined();
    });

    it('rejects non-numeric string', () => {
      const result = validateRecipeId('abc');
      expect(result.valid).toBe(false);
      expect(result.error).toBeDefined();
    });

    it('rejects float', () => {
      const result = validateRecipeId(3.14);
      expect(result.valid).toBe(false);
      expect(result.error).toBeDefined();
    });
  });
});
