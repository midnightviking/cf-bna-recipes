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