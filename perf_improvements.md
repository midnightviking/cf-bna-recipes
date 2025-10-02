## Refactoring and Readability Suggestions for RecipeForm.svelte

### Problem

- `RecipeForm.svelte` is large, complex, and hard to maintain. It mixes state, logic, and UI for many concerns (sections, ingredients, alternates, extensions, etc.).

### Goals

- Improve readability and maintainability.
- Make use of SvelteKit and Svelte 5 idioms (runes, context, modularity).
- Enable easier testing and future feature additions.

### Steps to Refactor

1. **Split into Smaller Components**
	- Move each major UI block (ingredient list, section editor, alternates, extensions, etc.) into its own Svelte component in `src/lib/components/recipe_form/`.
	- Example: `SectionList.svelte`, `IngredientList.svelte`, `RecipeMetaFields.svelte`, `RecipeInstructions.svelte`, `AlternatesEditor.svelte`, etc.

2. **Use Svelte 5 Runes and Stores**
	- Replace `$state` and `$derived` with Svelte 5 runes (`$state`, `$effect`, `$props`, etc.) in each component for local state.
	- Use context to share state or actions between components (e.g., provide `ingredient_list` and `section_list` via context).

3. **Move Business Logic to Module Scripts**
	- Extract non-UI logic (sorting, grouping, validation, etc.) into module scripts or utility files (e.g., `src/lib/utils/recipe.js`).
	- Keep Svelte components focused on UI and user interaction.

4. **Leverage SvelteKit Form Actions (if possible)**
	- Consider using SvelteKit form actions for save/update logic, reducing the need for manual fetch calls and improving progressive enhancement.

5. **Type Everything**
	- Add TypeScript types for props, state, and events in all components for better safety and editor support.

6. **Add Comments and Documentation**
	- Document component responsibilities, expected props, and context usage.

7. **Test Each Component in Isolation**
	- Use SvelteKit's dev server to test each new component as you extract it.

### Example Component Split

- `RecipeForm.svelte` (main orchestrator, handles save/cancel, provides context)
- `SectionList.svelte` (renders and manages sections)
- `IngredientList.svelte` (renders and manages ingredients for a section)
- `AlternatesEditor.svelte` (handles alternates UI)
- `ExtensionsEditor.svelte` (handles extensions UI)
- `RecipeMetaFields.svelte` (title, category, type, etc.)
- `RecipeInstructions.svelte` (instructions, CCP, substitutions)

### Benefits

- Smaller, focused files are easier to read, test, and maintain.
- Svelte 5 runes and context make state management more predictable and modular.
- Future features (like drag-and-drop, validation, or new fields) can be added with less risk of breaking unrelated code.
## Performance Suggestions for API and Server Folders

### 1. N+1 Query Pattern in Recipe List Endpoint

- **Location:** `src/routes/api/recipes/+server.js` (GET handler)
- **Issue:** Calls `getRecipeWithIngredients` for each recipe, resulting in 1 + (N * M) queries for N recipes.
- **Suggestion:** Refactor to batch-fetch related data (ingredients, sections, alternates) for all recipes in a single set of queries, then group them in memory. This reduces queries from O(N) to O(1) per entity type.

### 2. Batching and Grouping Related Data

- **Location:** `src/lib/server/recipes.js` (getRecipeWithIngredients and related logic)
- **Issue:** Each call fetches ingredients, sections, alternates, and extensions for a single recipe.
- **Suggestion:** When listing many recipes, fetch all ingredients, sections, alternates, and extensions for all relevant recipe IDs in one query per table, then group by recipe ID in JavaScript.

### 3. Redundant or Repeated Queries

- **Issue:** Some endpoints may re-fetch the same data (e.g., ingredient names, unit names) multiple times in a single request.
- **Suggestion:** Cache lookups for static reference data within the request scope, or fetch all needed reference data in a single query and join in memory.

### 4. Use of Left Joins

- **Observation:** Use of `.leftJoin` in ingredient and alternate queries is good for reducing round-trips, but ensure that indexes exist on join columns (e.g., `ingredient_id`, `unit_id`).
- **Suggestion:** Double-check that your database schema has indexes on all foreign key columns used in joins.

### 5. Write Operations

- **Observation:** Batch inserts are already used for ingredients, sections, extensions, and alternates.
- **Suggestion:** Continue to minimize writes by only updating changed rows and using batch operations where possible.

### 6. Metrics and Instrumentation

- **Observation:** Per-request query timing and count metrics are in place.
- **Suggestion:** Periodically review metrics to spot endpoints with high query counts or long durations, and prioritize those for batching or query reduction.