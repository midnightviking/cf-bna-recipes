/**
 * Validation schemas and functions for recipes and related entities
 * 
 * This module provides runtime validation for all user inputs before
 * they reach the database. This prevents data corruption and provides
 * clear error messages to users.
 * 
 * Usage:
 * const validation = validateRecipeStructure(data);
 * if (!validation.valid) {
 *   return errorResponse(validation);
 * }
 */

/**
 * Validate a recipe object before database operations
 * @param {Object} recipe - Recipe data to validate
 * @returns {Object} { valid: boolean, errors: { [key]: string[] } }
 * 
 * @example
 * const result = validateRecipe({
 *   title: 'Chicken Soup',
 *   initialServings: 4
 * });
 * // Returns: { valid: true, errors: {} }
 */
export function validateRecipe(recipe) {
  const errors = {};

  // Required fields
  if (!recipe || typeof recipe !== 'object') {
    return {
      valid: false,
      errors: { recipe: ['Recipe data is required'] }
    };
  }

  // Title validation
  if (!recipe.title || typeof recipe.title !== 'string' || recipe.title.trim() === '') {
    errors.title = ['Title is required and must be a non-empty string'];
  }

  // Optional numeric field validations
  if (recipe.initialServings !== undefined && recipe.initialServings !== null) {
    const servings = Number(recipe.initialServings);
    if (isNaN(servings) || servings <= 0) {
      errors.initialServings = ['Initial servings must be a positive number'];
    }
  }

  // String fields (all optional, but if provided must be strings)
  const stringFields = ['minTemp', 'itemType', 'portionSize', 'calories', 'protein', 'category', 'instructions', 'ccp', 'substitutions'];
  for (const field of stringFields) {
    if (recipe[field] !== undefined && recipe[field] !== null && typeof recipe[field] !== 'string') {
      errors[field] = [`${field} must be a string`];
    }
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors
  };
}

/**
 * Validate an ingredient object before database operations
 * @param {Object} ingredient - Ingredient data to validate
 * @returns {Object} { valid: boolean, errors: { [key]: string[] } }
 * 
 * @example
 * const result = validateIngredient({
 *   ingredient_id: 1,
 *   quantity: 2,
 *   unit_id: 3
 * });
 * // Returns: { valid: true, errors: {} }
 */
export function validateIngredient(ingredient) {
  const errors = {};

  if (!ingredient || typeof ingredient !== 'object') {
    return {
      valid: false,
      errors: { ingredient: ['Ingredient data is required'] }
    };
  }

  // ingredient_id validation (must be positive integer or null for new ingredients)
  if (ingredient.ingredient_id === undefined || ingredient.ingredient_id === null) {
    errors.ingredient_id = ['Ingredient must be selected'];
  } else if (!Number.isInteger(ingredient.ingredient_id) || ingredient.ingredient_id <= 0) {
    errors.ingredient_id = ['Ingredient ID must be a positive integer'];
  }

  // quantity validation
  if (ingredient.quantity === undefined || ingredient.quantity === null) {
    errors.quantity = ['Quantity is required'];
  } else {
    const qty = Number(ingredient.quantity);
    if (isNaN(qty) || qty <= 0) {
      errors.quantity = ['Quantity must be a positive number'];
    }
  }

  // unit_id validation
  if (ingredient.unit_id === undefined || ingredient.unit_id === null) {
    errors.unit_id = ['Unit must be selected'];
  } else if (!Number.isInteger(ingredient.unit_id) || ingredient.unit_id <= 0) {
    errors.unit_id = ['Unit ID must be a positive integer'];
  }

  // section_id validation (optional but must be valid if provided)
  if (ingredient.section_id !== undefined && ingredient.section_id !== null) {
    if (!Number.isInteger(ingredient.section_id) || ingredient.section_id <= 0) {
      errors.section_id = ['Section ID must be a positive integer or null'];
    }
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors
  };
}

/**
 * Validate a section object before database operations
 * @param {Object} section - Section data to validate
 * @returns {Object} { valid: boolean, errors: { [key]: string[] } }
 * 
 * @example
 * const result = validateSection({ name: 'Soup' });
 * // Returns: { valid: true, errors: {} }
 */
export function validateSection(section) {
  const errors = {};

  if (!section || typeof section !== 'object') {
    return {
      valid: false,
      errors: { section: ['Section data is required'] }
    };
  }

  // Section name validation
  if (!section.name || typeof section.name !== 'string' || section.name.trim() === '') {
    errors.name = ['Section name is required and must be a non-empty string'];
  }

  // Section ordering validation (optional but must be valid if provided)
  if (section.ordering !== undefined && section.ordering !== null) {
    if (!Number.isInteger(section.ordering) || section.ordering < 0) {
      errors.ordering = ['Section ordering must be a non-negative integer'];
    }
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors
  };
}

/**
 * Validate an alternate ingredient object
 * @param {Object} alternate - Alternate ingredient data to validate
 * @returns {Object} { valid: boolean, errors: { [key]: string[] } }
 * 
 * @example
 * const result = validateAlternate({
 *   original_ingredient: 1,
 *   alternate_ingredient: 2,
 *   quantity: 1,
 *   unit_id: 3
 * });
 * // Returns: { valid: true, errors: {} }
 */
export function validateAlternate(alternate) {
  const errors = {};

  if (!alternate || typeof alternate !== 'object') {
    return {
      valid: false,
      errors: { alternate: ['Alternate data is required'] }
    };
  }

  // alternate_ingredient validation
  if (alternate.alternate_ingredient === undefined || alternate.alternate_ingredient === null) {
    errors.alternate_ingredient = ['Alternate ingredient must be selected'];
  } else if (!Number.isInteger(alternate.alternate_ingredient) || alternate.alternate_ingredient <= 0) {
    errors.alternate_ingredient = ['Alternate ingredient ID must be a positive integer'];
  }

  // quantity validation
  if (alternate.quantity === undefined || alternate.quantity === null) {
    errors.quantity = ['Quantity is required'];
  } else {
    const qty = Number(alternate.quantity);
    if (isNaN(qty) || qty <= 0) {
      errors.quantity = ['Quantity must be a positive number'];
    }
  }

  // unit_id validation
  if (alternate.unit_id === undefined || alternate.unit_id === null) {
    errors.unit_id = ['Unit must be selected'];
  } else if (!Number.isInteger(alternate.unit_id) || alternate.unit_id <= 0) {
    errors.unit_id = ['Unit ID must be a positive integer'];
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors
  };
}

/**
 * Validate entire recipe structure (main recipe + all related entities)
 * 
 * @param {Object} recipeData - Full recipe data including related entities
 * @returns {Object} { valid: boolean, errors: Object }
 * 
 * @example
 * const result = validateRecipeStructure({
 *   title: 'Soup',
 *   sections: [{ name: 'Base' }],
 *   ingredients: [
 *     { ingredient_id: 1, quantity: 2, unit_id: 3 }
 *   ]
 * });
 * // Returns: { valid: true, errors: {} }
 */
export function validateRecipeStructure(recipeData) {
  const errors = {};

  // Validate main recipe
  const recipeValidation = validateRecipe(recipeData);
  if (!recipeValidation.valid) {
    errors.recipe = recipeValidation.errors;
  }

  // Validate sections if present
  if (Array.isArray(recipeData.sections) && recipeData.sections.length > 0) {
    const sectionErrors = [];
    for (let i = 0; i < recipeData.sections.length; i++) {
      const section = recipeData.sections[i];
      const result = validateSection(section);
      if (!result.valid) {
        sectionErrors.push({ index: i, errors: result.errors });
      }
    }
    if (sectionErrors.length > 0) {
      errors.sections = sectionErrors;
    }
  }

  // Validate ingredients if present
  if (Array.isArray(recipeData.ingredients) && recipeData.ingredients.length > 0) {
    const ingredientErrors = [];
    for (let i = 0; i < recipeData.ingredients.length; i++) {
      const ingredient = recipeData.ingredients[i];
      const result = validateIngredient(ingredient);
      if (!result.valid) {
        ingredientErrors.push({ index: i, errors: result.errors });
      }
    }
    if (ingredientErrors.length > 0) {
      errors.ingredients = ingredientErrors;
    }
  }

  // Validate alternates if present
  if (Array.isArray(recipeData.alternates) && recipeData.alternates.length > 0) {
    const alternateErrors = [];
    for (let i = 0; i < recipeData.alternates.length; i++) {
      const alternate = recipeData.alternates[i];
      const result = validateAlternate(alternate);
      if (!result.valid) {
        alternateErrors.push({ index: i, errors: result.errors });
      }
    }
    if (alternateErrors.length > 0) {
      errors.alternates = alternateErrors;
    }
  }

  // Validate extensions if present
  if (Array.isArray(recipeData.extensions)) {
    const extensionErrors = [];
    for (let i = 0; i < recipeData.extensions.length; i++) {
      const extId = recipeData.extensions[i];
      if (!Number.isInteger(extId) || extId <= 0) {
        extensionErrors.push({
          index: i,
          error: 'Extension ID must be a positive integer'
        });
      }
    }
    if (extensionErrors.length > 0) {
      errors.extensions = extensionErrors;
    }
  }

  const hasErrors = Object.keys(errors).length > 0;
  return {
    valid: !hasErrors,
    errors: hasErrors ? errors : {}
  };
}

/**
 * Validate recipe ID for operations that need it
 * @param {*} id - ID to validate
 * @returns {Object} { valid: boolean, error: string | null }
 */
export function validateRecipeId(id) {
  if (id === undefined || id === null) {
    return { valid: false, error: 'Recipe ID is required' };
  }

  const numId = Number(id);
  if (!Number.isInteger(numId) || numId <= 0) {
    return { valid: false, error: 'Recipe ID must be a positive integer' };
  }

  return { valid: true, error: null };
}
