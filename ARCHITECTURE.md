# Architecture Overview

## Current Data Flow

```
┌─────────────────────────────────────────────────────────────┐
│                        BROWSER (Client)                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │  RecipeForm.svelte (Top-level State Management)   │    │
│  └────────────────────────────────────────────────────┘    │
│              ↓                                               │
│  ┌─────────────────┬──────────────────┬─────────────────┐  │
│  │AddIngredient    │ ingredientList   │ SectionList     │  │
│  │Form.svelte      │ (mutable state)  │ .svelte         │  │
│  └─────────────────┴──────────────────┴─────────────────┘  │
│        ↓                    ↓                 ↓              │
│  (direct mutation)  (drag-drop updates)  (temp section)    │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │            POST/PUT /api/recipes                   │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
         ↓                                       ↑
         │                                       │
┌────────┴──────────────────────────────────────┴───────────┐
│              NETWORK + ERROR HANDLING                       │
│  ⚠️ Minimal error handling                                 │
│  ⚠️ No retry logic                                         │
│  ⚠️ No loading states tracked                              │
└────────┬──────────────────────────────────────┬───────────┘
         ↓                                       ↑
┌─────────────────────────────────────────────────────────────┐
│                    SERVER (Backend)                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  /api/recipes/+server.js                                   │
│  ├─ POST handler                                           │
│  │   ↓                                                     │
│  │  ⚠️ NO INPUT VALIDATION                               │
│  │   ↓                                                     │
│  │  recipe-operations.js → createRecipe()                 │
│  │                                                         │
│  ├─ PUT handler                                            │
│  │   ↓ (same as POST)                                     │
│  │   updateRecipe()                                        │
│  │   ⚠️ NO TRANSACTION SUPPORT                            │
│  │   ├─ upsertSections()                                  │
│  │   ├─ upsertIngredients()  ← If fails, sections orphaned│
│  │   ├─ upsertExtensions()   ← If fails, data inconsistent│
│  │   └─ upsertAlternates()                                │
│  │                                                         │
│  └─ GET handler                                            │
│      ↓ (batch optimize)                                    │
│      recipes.js → getRecipeWithIngredients()              │
│                                                             │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│              DATABASE (D1 SQLite)                           │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  recipes                  recipe_sections                   │
│  ├─ id (PK)              ├─ id (PK)                         │
│  ├─ title                ├─ recipe_id (FK)                 │
│  ├─ instructions         ├─ name                           │
│  └─ ...metadata          └─ ordering                       │
│                                                              │
│  recipe_ingredients       alternate_ingredients             │
│  ├─ id (PK)              ├─ id (PK)                         │
│  ├─ recipe_id (FK)       ├─ recipe_id (FK)                 │
│  ├─ ingredient_id (FK)   ├─ original_ingredient (FK?)       │
│  ├─ quantity             ├─ alternate_ingredient (FK)       │
│  ├─ unit (FK)            ├─ quantity                       │
│  ├─ section_id (FK?)     ├─ unit_id (FK)                   │
│  └─ ordering             └─ extensions (string - CSV!)      │
│                                                              │
│  ingredients              extensions                        │
│  ├─ id (PK)              ├─ id (PK)                         │
│  ├─ name (UNIQUE)        ├─ name (UNIQUE)                  │
│  └─ ...                  └─ ...                            │
│                                                              │
│  recipe_extensions                                          │
│  ├─ id (PK)                                                │
│  ├─ recipe_id (FK)                                         │
│  └─ extension_id (FK)                                      │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Issues Identified

### 🔴 Critical Issues

1. **No Input Validation**
   - Direct JSON → DB without checks
   - Invalid data creates constraint violations
   - No clear error messages

2. **No Transactions**
   - Multi-table operations can partially fail
   - Creates orphaned/inconsistent data
   - Difficult to recover from failures

3. **Unclear Error Handling**
   - Generic error responses
   - Components don't show loading states
   - Network errors not handled gracefully

### 🟡 Medium Issues

4. **Duplicate Data Transforms**
   - `getRecipeWithIngredients()` vs GET endpoint both normalize data
   - Risk of inconsistency
   - Code maintenance burden

5. **State Management Sprawl**
   - Recipe state in RecipeForm component
   - State mutations in child components (IngredientList)
   - Hard to trace state changes

6. **Fragile ID System**
   - `_localIndex` as React key-like identifier
   - Section ID resolution via Map lookups
   - Temp IDs (-1, -2, etc.) magic numbers

### 🟢 Minor Issues

7. **No Type Safety**
   - JavaScript only
   - No runtime validation of contracts
   - Props shapes not documented

8. **Limited Test Coverage**
   - No visible test infrastructure
   - Business logic untested
   - Hard to refactor with confidence

---

## Proposed Architecture (After Refactoring)

```
┌─────────────────────────────────────────────────────────────┐
│                        BROWSER (Client)                      │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │            RecipeForm.svelte                       │    │
│  │  (Orchestrator, UI composition, no state logic)   │    │
│  └────────────────────────────────────────────────────┘    │
│              ↓                                               │
│  ┌─────────────────┬──────────────────┬─────────────────┐  │
│  │AddIngredient    │DraggableList     │SectionList      │  │
│  │Form.svelte      │.svelte           │.svelte          │  │
│  │(controlled)     │(reusable)        │(controlled)     │  │
│  └─────────────────┴──────────────────┴─────────────────┘  │
│        ↓                    ↓                 ↓              │
│  (dispatch events)  (dispatch events)  (dispatch events)   │
│                                                              │
│  ┌────────────────────────────────────────────────────┐    │
│  │  recipe.js Store (Svelte)                          │    │
│  │  ├─ recipeState ($state)                           │    │
│  │  ├─ addIngredient(ing)                             │    │
│  │  ├─ removeIngredient(id)                           │    │
│  │  ├─ updateSection(...)                             │    │
│  │  └─ validateState() → error?                       │    │
│  └────────────────────────────────────────────────────┘    │
│              ↓                                               │
│  ┌────────────────────────────────────────────────────┐    │
│  │  API Client (client.js)                            │    │
│  │  ├─ validateInput(data) → Promise<errors>          │    │
│  │  ├─ post() → Promise<recipe | error>               │    │
│  │  ├─ put() → Promise<recipe | error>                │    │
│  │  ├─ loading: $state                                │    │
│  │  ├─ errors: $state                                 │    │
│  │  └─ retry()                                        │    │
│  └────────────────────────────────────────────────────┘    │
│              ↓                                               │
│  ┌────────────────────────────────────────────────────┐    │
│  │  Notifications (Toast)                             │    │
│  │  ├─ showError(msg)                                 │    │
│  │  ├─ showSuccess(msg)                               │    │
│  │  └─ showLoading(msg)                               │    │
│  └────────────────────────────────────────────────────┘    │
└─────────────────────────────────────────────────────────────┘
         ↓                                       ↑
         │                                       │
┌────────┴──────────────────────────────────────┴───────────┐
│       NETWORK + ERROR HANDLING (Robust)                    │
│  ✅ Validation on both sides                              │
│  ✅ Retry with exponential backoff                        │
│  ✅ Loading & error states tracked                        │
│  ✅ User-friendly error messages                          │
└────────┬──────────────────────────────────────┬───────────┘
         ↓                                       ↑
┌─────────────────────────────────────────────────────────────┐
│                    SERVER (Backend)                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  /api/recipes/+server.js                                   │
│  ├─ errorResponse() helper                                 │
│  │   └─ Logs, returns { error, code, fields }              │
│  │                                                          │
│  ├─ POST handler                                           │
│  │   ↓                                                     │
│  │  1. validateRecipeInput(data)                          │
│  │     ├─ Checks required fields                          │
│  │     ├─ Validates data types                            │
│  │     ├─ Checks ingredient IDs exist                     │
│  │     └─ Returns: { valid: bool, errors: {...} }        │
│  │   ↓ (throw if invalid)                                │
│  │  2. db.transaction(async () => {                       │
│  │       return createRecipe(db, data);                   │
│  │     })                                                 │
│  │   ↓ (rollback on any error)                           │
│  │  3. getRecipeWithIngredients(id)                       │
│  │   ↓ (return formatted response)                        │
│  │  200 { recipe, timestamp, version }                    │
│  │                                                         │
│  ├─ PUT handler (same pattern)                            │
│  │                                                         │
│  └─ GET handler                                            │
│      └─ getRecipeWithIngredients()                        │
│         (uses shared data-transforms.js)                  │
│                                                             │
│  ┌────────────────────────────────────────────────────┐   │
│  │ validation/ (New)                                  │   │
│  │ ├─ schemas.js (Define shape of valid recipes)     │   │
│  │ │  ├─ validateRecipe(data)                        │   │
│  │ │  ├─ validateIngredient(ing)                     │   │
│  │ │  ├─ validateSection(sec)                        │   │
│  │ │  └─ validateAlternate(alt)                      │   │
│  │ └─ errors.js (Error code definitions)             │   │
│  │                                                     │   │
│  ├─ data-transforms.js (New)                          │   │
│  │ ├─ normalizeRecipe(rawData)                        │   │
│  │ ├─ groupIngredientsBySection(ings, secs)          │   │
│  │ ├─ parseExtensions(extString)                      │   │
│  │ └─ formatRecipeResponse(recipe)                    │   │
│  │                                                     │   │
│  ├─ recipe-operations.js (Enhanced)                   │   │
│  │ ├─ createRecipe(db, data)                          │   │
│  │ │  └─ Wraps in transaction                         │   │
│  │ ├─ updateRecipe(db, data)                          │   │
│  │ │  └─ Wraps in transaction                         │   │
│  │ ├─ upsertSections(...)                             │   │
│  │ ├─ upsertIngredients(...)                          │   │
│  │ ├─ upsertExtensions(...)                           │   │
│  │ └─ upsertAlternates(...)                           │   │
│  │                                                     │   │
│  └─ recipes.js (Refactored)                           │   │
│     └─ getRecipeWithIngredients(id)                   │   │
│        (uses data-transforms.normalizeRecipe)         │   │
│                                                         │   │
└─────────────────────────────────────────────────────────────┘
         ↓
┌─────────────────────────────────────────────────────────────┐
│              DATABASE (D1 SQLite) - ENHANCED                │
├─────────────────────────────────────────────────────────────┤
│  Schema enhancements (Future):                              │
│  ├─ recipes.version (for optimistic locking)              │
│  ├─ recipes.updated_at (for audit)                        │
│  └─ recipe_history (change tracking table)                │
│                                                              │
│  Foreign keys enabled (Already in schema):                 │
│  ├─ Prevents orphaned records                             │
│  ├─ Ensures referential integrity                         │
│  └─ Rolls back partial updates in transactions            │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

## Key Improvements

| Aspect | Before | After |
|--------|--------|-------|
| **Validation** | None | Two-layer (client + server) |
| **Error Handling** | Generic messages | Detailed error responses |
| **Consistency** | Possible partial failures | Transactional guarantees |
| **Data Transforms** | Duplicated | Single source of truth |
| **State Management** | Scattered across components | Centralized store |
| **Type Safety** | No documentation | JSDoc + runtime validation |
| **Testing** | Untested | >80% coverage target |
| **Error Recovery** | Manual refresh | Automatic retry + rollback |

## Component Dependency Map (After Refactoring)

```
RecipeForm.svelte
├─ Imports: recipe.store, api.client, notifications
├─ Props: None (reads from store)
├─ Dispatches: recipe:save, recipe:load
│
├─ AddIngredientForm.svelte
│  ├─ Imports: validation.schemas, notifications
│  ├─ Props: units (context)
│  └─ Dispatches: ingredient:add
│
├─ SectionList.svelte
│  ├─ Imports: DraggableList
│  ├─ Props: sections
│  └─ Dispatches: section:reorder
│
└─ IngredientList.svelte
   ├─ Imports: DraggableList
   ├─ Props: ingredients, sections
   └─ Dispatches: ingredient:move, ingredient:remove

DraggableList.svelte (Reusable)
├─ Imports: drag-drop.utils
├─ Props: items, onReorder, onMove
└─ Generic list with drag-drop support
```

---

## Migration Path

### Step 1: Add Validation (Doesn't break anything)
- Add validation schemas alongside existing code
- Call validation from API handlers
- Return detailed errors

### Step 2: Add Transactions (Non-breaking)
- Wrap operations in transactions
- Same external API
- Safer internal behavior

### Step 3: Consolidate Data Transforms (Refactoring)
- Create shared functions
- Update endpoints to use them
- Verify outputs match

### Step 4: Centralize State (Optional, can be gradual)
- Create recipe store
- Migrate components one at a time
- Fallback to props during transition

### Step 5: Extract Utilities (Cleanup)
- Extract drag-drop logic
- Create reusable components
- No functional changes

---

## Testing Strategy

```
Unit Tests (Vitest)
├─ validation/schemas.test.js
├─ data-transforms.test.js
├─ recipe-operations.test.js (mocked DB)
└─ components/*.test.js (Vitest components)

Integration Tests
├─ /api/recipes POST/PUT/GET/DELETE
├─ Full recipe flow (create → edit → delete)
└─ Error recovery scenarios

E2E Tests (Optional - Playwright)
├─ User creates recipe
├─ User edits recipe
├─ User adds ingredients with drag-drop
└─ Errors and retries

Performance Tests
├─ Recipe load time baseline
├─ Rendering performance
└─ Memory usage with many ingredients
```
