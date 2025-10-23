# Quick Wins - Start Today

These are targeted, achievable tasks that will immediately improve code robustness with minimal time investment. **Estimated time: 2-3 hours total**

---

## Quick Win #1: Add Error Context to API Handlers (30 min)

**File**: `src/routes/api/recipes/+server.js`

**Current State**:
```javascript
function errorResponse(error) {
  return new Response(JSON.stringify({ error: error.message || error.toString() }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}
```

**Problem**: Generic error messages don't help debugging

**Improvement**:
```javascript
function errorResponse(error, context = {}) {
  console.error(`[API Error] ${context.endpoint}:`, error);
  
  // Map common database errors to user-friendly messages
  let userMessage = error.message;
  let code = 'INTERNAL_ERROR';
  
  if (error.message?.includes('UNIQUE constraint')) {
    userMessage = 'This item already exists';
    code = 'DUPLICATE_ENTRY';
  } else if (error.message?.includes('FOREIGN KEY')) {
    userMessage = 'Reference to non-existent item';
    code = 'INVALID_REFERENCE';
  } else if (error.message?.includes('NOT NULL')) {
    userMessage = 'Missing required field';
    code = 'MISSING_FIELD';
  }
  
  return new Response(JSON.stringify({ 
    error: userMessage,
    code,
    timestamp: new Date().toISOString(),
    ...process.env.DEV ? { debug: error.message } : {}
  }), {
    status: 500,
    headers: { 'Content-Type': 'application/json' }
  });
}

// Usage in handlers
export async function POST({ request, locals }) {
  try {
    // ... existing code ...
  } catch (error) {
    return errorResponse(error, { endpoint: 'POST /api/recipes' });
  }
}
```

**Benefits**:
- Better error debugging
- User-friendly messages
- Automatic error categorization
- Easier to add error tracking later

---

## Quick Win #2: Create Simple Toast/Notification Component (30 min)

**File**: `src/lib/components/Toast.svelte` (new)

```svelte
<script>
  let notifications = $state([]);

  export function show(message, type = 'info', duration = 3000) {
    const id = Math.random();
    notifications.push({ id, message, type });
    
    if (duration > 0) {
      setTimeout(() => {
        notifications = notifications.filter(n => n.id !== id);
      }, duration);
    }
    
    return id;
  }

  export function error(message) {
    return show(message, 'error', 5000);
  }

  export function success(message) {
    return show(message, 'success', 3000);
  }

  export function info(message) {
    return show(message, 'info', 3000);
  }

  export function remove(id) {
    notifications = notifications.filter(n => n.id !== id);
  }
</script>

<div class="toast-container">
  {#each notifications as notif (notif.id)}
    <div class="toast toast-{notif.type}">
      {notif.message}
      <button onclick={() => remove(notif.id)}>×</button>
    </div>
  {/each}
</div>

<style>
  .toast-container {
    position: fixed;
    bottom: 20px;
    right: 20px;
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;
    max-width: 400px;
  }

  .toast {
    padding: 12px 16px;
    border-radius: 4px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
    animation: slideIn 0.3s ease-out;
  }

  .toast-error {
    background-color: #fee;
    color: #c33;
    border-left: 4px solid #c33;
  }

  .toast-success {
    background-color: #efe;
    color: #3c3;
    border-left: 4px solid #3c3;
  }

  .toast-info {
    background-color: #eef;
    color: #33c;
    border-left: 4px solid #33c;
  }

  button {
    background: none;
    border: none;
    cursor: pointer;
    font-size: 20px;
    margin-left: 12px;
    padding: 0;
    color: inherit;
    opacity: 0.7;
  }

  button:hover {
    opacity: 1;
  }

  @keyframes slideIn {
    from {
      transform: translateX(400px);
      opacity: 0;
    }
    to {
      transform: translateX(0);
      opacity: 1;
    }
  }
</style>
```

**File**: `src/routes/+layout.svelte` (add at top level)
```svelte
<script>
  import Toast from '$lib/components/Toast.svelte';
  let toastComponent;
</script>

<!-- Global toast notifications -->
<Toast bind:this={toastComponent} />

<!-- Rest of layout -->
```

**Benefits**:
- Visible error feedback for users
- Can show loading, success, errors
- Reusable across app
- Easy to extend

---

## Quick Win #3: Add Basic JSDoc to recipe-operations.js (45 min)

**File**: `src/lib/server/recipe-operations.js`

Add comprehensive JSDoc comments to each function:

```javascript
/**
 * Upsert sections for a recipe (create/update/delete)
 * 
 * @param {*} db - Drizzle database instance
 * @param {number} recipeId - ID of the recipe
 * @param {Array<{id?: number, name: string, ordering?: number}>} sections - Array of section objects
 * @param {boolean} [isUpdate=false] - Whether this is an update (vs create) operation
 * @returns {Promise<Map<string|number, number>>} Map of section keys/names to real section IDs
 * 
 * @throws {Error} If database operation fails
 * 
 * @example
 * const sectionIdMap = await upsertSections(db, 1, [
 *   { id: 1, name: 'Soup', ordering: 0 },
 *   { name: 'Dumplings', ordering: 1 }  // new section, no id
 * ], true);
 * 
 * @description
 * - On INSERT: Creates new sections from records without `id`
 * - On UPDATE: Updates existing sections if changed, creates new ones, deletes removed ones
 * - Returns a Map to allow resolving section IDs by name or ID later
 */
export async function upsertSections(db, recipeId, sections, isUpdate = false) {
  // ... implementation ...
}

/**
 * Create a new recipe with all related data in a single transaction
 * 
 * @param {*} db - Drizzle database instance
 * @param {Object} data - Recipe data
 * @param {string} data.title - Recipe title (required)
 * @param {string} [data.instructions] - Cooking instructions
 * @param {number} [data.minTemp] - Minimum temperature
 * @param {string} [data.itemType] - Type of item (e.g., 'soup')
 * @param {string} [data.portionSize] - Portion size description
 * @param {string} [data.calories] - Calorie count
 * @param {string} [data.protein] - Protein amount
 * @param {string} [data.category] - Recipe category
 * @param {string} [data.ccp] - Critical control point
 * @param {string} [data.substitutions] - Substitution notes
 * @param {number} [data.initialServings] - Initial serving count
 * @param {Array} [data.sections=[]] - Recipe sections
 * @param {Array} [data.ingredients=[]] - Recipe ingredients
 * @param {Array} [data.extensions=[]] - Extension IDs
 * @param {Array} [data.alternates=[]] - Alternate ingredients
 * 
 * @returns {Promise<Object>} The created recipe object with id
 * @throws {Error} If validation fails or database operation fails
 * 
 * @example
 * const recipe = await createRecipe(db, {
 *   title: 'Chicken Soup',
 *   instructions: 'Boil and serve',
 *   sections: [{ name: 'Broth' }, { name: 'Toppings' }],
 *   ingredients: [...]
 * });
 * // Returns: { id: 123, title: 'Chicken Soup', ... }
 */
export async function createRecipe(db, data) {
  // ... implementation ...
}

// Add similar detailed comments to: updateRecipe, upsertIngredients, upsertExtensions, upsertAlternates
```

**Benefits**:
- IDE autocomplete + type hints
- Documentation in code
- Clear contract for each function
- Easier to maintain

---

## Quick Win #4: Create First Validation Schema (30 min)

**File**: `src/lib/server/validation.js` (new)

```javascript
/**
 * Validation schemas and functions for recipes and related entities
 */

/**
 * Validate a recipe object before database operations
 * @param {Object} recipe - Recipe data to validate
 * @returns {Object} { valid: boolean, errors: { [key]: string[] } }
 */
export function validateRecipe(recipe) {
  const errors = {};

  // Required fields
  if (!recipe.title || typeof recipe.title !== 'string' || recipe.title.trim() === '') {
    errors.title = ['Title is required'];
  }

  if (recipe.initialServings !== undefined && recipe.initialServings <= 0) {
    errors.initialServings = ['Initial servings must be positive'];
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
 */
export function validateIngredient(ingredient) {
  const errors = {};

  if (!ingredient.ingredient_id || typeof ingredient.ingredient_id !== 'number') {
    errors.ingredient_id = ['Ingredient must be selected'];
  }

  if (ingredient.quantity === null || ingredient.quantity === undefined) {
    errors.quantity = ['Quantity is required'];
  } else if (Number(ingredient.quantity) <= 0) {
    errors.quantity = ['Quantity must be positive'];
  }

  if (!ingredient.unit_id || typeof ingredient.unit_id !== 'number') {
    errors.unit_id = ['Unit must be selected'];
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
 */
export function validateSection(section) {
  const errors = {};

  if (!section.name || typeof section.name !== 'string' || section.name.trim() === '') {
    errors.name = ['Section name is required'];
  }

  return {
    valid: Object.keys(errors).length === 0,
    errors
  };
}

/**
 * Validate entire recipe structure
 * @param {Object} recipeData - Full recipe data including related entities
 * @returns {Object} { valid: boolean, errors: Object }
 */
export function validateRecipeStructure(recipeData) {
  const errors = {};

  // Validate main recipe
  const recipeValidation = validateRecipe(recipeData);
  if (!recipeValidation.valid) {
    errors.recipe = recipeValidation.errors;
  }

  // Validate sections if present
  if (Array.isArray(recipeData.sections)) {
    const sectionErrors = recipeData.sections.map((s, i) => {
      const result = validateSection(s);
      return result.valid ? null : { index: i, errors: result.errors };
    }).filter(Boolean);
    if (sectionErrors.length > 0) {
      errors.sections = sectionErrors;
    }
  }

  // Validate ingredients if present
  if (Array.isArray(recipeData.ingredients)) {
    const ingredientErrors = recipeData.ingredients.map((i, idx) => {
      const result = validateIngredient(i);
      return result.valid ? null : { index: idx, errors: result.errors };
    }).filter(Boolean);
    if (ingredientErrors.length > 0) {
      errors.ingredients = ingredientErrors;
    }
  }

  const hasErrors = Object.keys(errors).length > 0;
  return {
    valid: !hasErrors,
    errors: hasErrors ? errors : {}
  };
}
```

**File**: `src/routes/api/recipes/+server.js` (update POST handler)

```javascript
import { validateRecipeStructure } from '$lib/server/validation.js';

export async function POST({ request, locals }) {
  try {
    const dbInitError = getDbInitError();
    if (dbInitError) throw dbInitError;
    const db = await getDb();
    const data = await request.json();

    // NEW: Validate input
    const validation = validateRecipeStructure(data);
    if (!validation.valid) {
      return new Response(JSON.stringify({
        error: 'Validation failed',
        code: 'VALIDATION_ERROR',
        fields: validation.errors
      }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    const inserted = await createRecipe(db, data);
    const recipe = await getRecipeWithIngredients(inserted.id, locals);

    return new Response(JSON.stringify(recipe), {
      status: 201,
      headers: { 'Content-Type': 'application/json' }
    });
  } catch (error) {
    return errorResponse(error, { endpoint: 'POST /api/recipes' });
  }
}
```

**Benefits**:
- Catches invalid data before it reaches database
- Clear error messages
- Reusable across endpoints
- Foundation for client-side validation

---

## Quick Win #5: Install Vitest & Create First Test (30 min)

**Terminal**:
```bash
npm install -D vitest @vitest/ui jsdom
```

**File**: `vitest.config.js` (new)

```javascript
import { defineConfig } from 'vitest/config';
import svelte from '@sveltejs/vite-plugin-svelte';

export default defineConfig({
  plugins: [svelte({ hot: !process.env.VITEST })],
  test: {
    globals: true,
    environment: 'jsdom',
    include: ['src/**/*.test.js'],
  }
});
```

**File**: `package.json` (add script)

```json
{
  "scripts": {
    "test": "vitest",
    "test:ui": "vitest --ui",
    "test:coverage": "vitest --coverage"
  }
}
```

**File**: `src/lib/server/__tests__/validation.test.js` (new)

```javascript
import { describe, it, expect } from 'vitest';
import {
  validateRecipe,
  validateIngredient,
  validateRecipeStructure
} from '../validation.js';

describe('Recipe Validation', () => {
  describe('validateRecipe', () => {
    it('accepts valid recipe', () => {
      const result = validateRecipe({
        title: 'Chicken Soup',
        initialServings: 4
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
    });

    it('rejects non-positive initial servings', () => {
      const result = validateRecipe({
        title: 'Test',
        initialServings: -1
      });
      expect(result.valid).toBe(false);
      expect(result.errors.initialServings).toBeDefined();
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
    });

    it('rejects ingredient without ingredient_id', () => {
      const result = validateIngredient({
        quantity: 2,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.ingredient_id).toBeDefined();
    });

    it('rejects ingredient with non-positive quantity', () => {
      const result = validateIngredient({
        ingredient_id: 1,
        quantity: 0,
        unit_id: 3
      });
      expect(result.valid).toBe(false);
      expect(result.errors.quantity).toBeDefined();
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
  });
});
```

**Run tests**:
```bash
npm test
```

**Benefits**:
- Test infrastructure in place
- Tests serve as documentation
- Catch regressions early
- Confidence for refactoring

---

## Quick Win #6: Add Loading State to RecipeForm (15 min)

**File**: `src/routes/(pages)/recipes/RecipeForm.svelte`

```javascript
let isLoading = $state(false);
let saveError = $state(null);

async function saveRecipe() {
  try {
    isLoading = true;
    saveError = null;

    const recipe = {
      // ... existing code ...
    };

    const endpoint = id ? `/api/recipes/${id}` : '/api/recipes';
    const method = id ? 'PUT' : 'POST';

    const response = await fetch(endpoint, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(recipe)
    });

    if (!response.ok) {
      const error = await response.json();
      saveError = error.error || 'Failed to save recipe';
      toast?.error?.(saveError);
      return;
    }

    toast?.success?.('Recipe saved successfully!');
    await goto('/recipes');
  } catch (error) {
    saveError = error.message;
    toast?.error?.(saveError);
  } finally {
    isLoading = false;
  }
}
```

Then in template:
```svelte
<Button on:click={saveRecipe} disabled={isLoading}>
  {isLoading ? 'Saving...' : 'Save Recipe'}
</Button>

{#if saveError}
  <div class="error-message">{saveError}</div>
{/if}
```

**Benefits**:
- User sees loading state
- Prevents duplicate submissions
- Error visible to user

---

## Implementation Checklist

- [ ] **Quick Win #1**: Better error context (30 min)
- [ ] **Quick Win #2**: Toast notification component (30 min)
- [ ] **Quick Win #3**: JSDoc comments on recipe-operations.js (45 min)
- [ ] **Quick Win #4**: Validation schemas + POST handler (30 min)
- [ ] **Quick Win #5**: Vitest setup + first test (30 min)
- [ ] **Quick Win #6**: Loading state in RecipeForm (15 min)

**Total Time**: ~2.5 hours

---

## How to Get Started

1. **Pick one quick win** above
2. **Copy the code** from the example
3. **Test it locally** (`npm run dev`)
4. **Commit**: `git add . && git commit -m "chore: add [quick win name]"`
5. **Move to next** after verification

---

## Follow-up

After completing quick wins, you'll have:
- ✅ Better error handling
- ✅ User-visible feedback
- ✅ Input validation in place
- ✅ Test infrastructure ready
- ✅ Clear function documentation
- ✅ Better UX during loading

This builds momentum for **Phase 1** of the full plan!
