# Code Stability & Robustness Plan
**Date**: October 23, 2025  
**Status**: Project Assessment & Planning

---

## Executive Summary

The **cf-bna-recipes** project is a Svelte 5 recipe management application with backend operations (Drizzle ORM, D1 SQLite). Recent refactoring (recipe-operations.js extraction) was good, but the codebase shows several fragility points that need addressing:

- **Minimal error handling** at both API and UI layers
- **Type safety gaps** (JavaScript/no validation layer)
- **State management brittleness** (reactive state scattered across components)
- **Inconsistent data normalization** (multiple places doing similar transforms)
- **Limited test coverage** (no visible tests or test infrastructure)
- **Component coupling issues** (tight dependencies, hard to test)
- **Missing input validation** (data flows from UI → API → DB with minimal checks)

---

## Current Architecture Assessment

### ✅ What's Working Well

1. **API Layer Refactoring** (Recent)
   - `recipe-operations.js` centralizes business logic
   - Clear CRUD functions with single responsibility
   - Removed significant code duplication (~60% reduction)
   - Good separation: HTTP handlers → business logic → DB

2. **Database Schema** 
   - Reasonable normalization
   - Proper use of Drizzle ORM
   - Good batch query optimization in GET endpoints

3. **UI Component Structure**
   - Components are reasonably modular (RecipeForm, AddIngredientForm, etc.)
   - Clear separation between form and display components
   - Uses modern Svelte 5 runes

### ⚠️ Fragility Points

1. **Missing Error Handling**
   - Try-catch blocks exist in API layer but minimal info returned
   - No error boundaries in components
   - Network failures not gracefully handled
   - Database constraint violations could crash handlers

2. **No Input Validation**
   - API endpoints accept data without schema validation
   - No client-side validation library
   - Direct database operations without pre-checks
   - Could lead to constraint violations or data corruption

3. **Type Safety Gaps**
   - JavaScript (no TypeScript)
   - No JSDoc type hints
   - No runtime validation of API contracts
   - Components rely on prop documentation

4. **State Management Complexity**
   - Multiple reactive variables across component hierarchy
   - State mutations scattered (e.g., ingredient_list updates in IngredientList.svelte)
   - `_localIndex` used as unstable key
   - Section ID resolution via Map lookups (fragile)

5. **Data Normalization Issues**
   - `getRecipeWithIngredients()` and GET `/api/recipes` do similar transforms
   - Duplicate ingredient/section grouping logic
   - Extensions parsing hardcoded as comma-separated strings
   - Manual string splits/joins error-prone

6. **Limited Test Coverage**
   - No test files visible in workspace
   - No test infrastructure (Jest, Vitest, etc.)
   - API endpoints untested
   - Component behavior undocumented

7. **Component Coupling**
   - IngredientList.svelte directly mutates parent state
   - Hard to test components in isolation
   - Dependencies on global context (units)
   - Circular data flow with dragging logic

8. **Missing Safeguards**
   - No transaction support for multi-table operations
   - No optimistic updates / rollback mechanism
   - No conflict resolution for concurrent edits
   - No audit trail / change history

---

## Detailed Issues & Solutions

### Issue 1: Zero Input Validation
**Severity**: HIGH  
**Impact**: Data corruption, constraint violations, API crashes

**Current State**:
```javascript
// /api/recipes/+server.js - POST handler
const data = await request.json();
const inserted = await createRecipe(db, data);  // No validation!
```

**Problems**:
- Missing required fields not caught
- Negative quantities accepted
- Invalid IDs not verified
- Empty strings for required fields

**Solution**:
Create a validation layer with clear contracts:
```
1. Define validation schemas for each entity (Recipe, Ingredient, Section, etc.)
2. Add validation middleware to API handlers
3. Add client-side validation before submission
4. Return detailed error messages with field-level feedback
```

### Issue 2: No Error Boundaries or Graceful Degradation
**Severity**: HIGH  
**Impact**: Silent failures, poor user feedback

**Current State**:
- API returns `{ error: "message" }` but components don't always handle
- Network errors may silently fail
- Form submission doesn't show loading/error states
- No retry mechanism

**Solution**:
```
1. Create error boundary component
2. Add toast/notification system for errors
3. Implement retry logic with exponential backoff
4. Show loading indicators during async operations
5. Provide meaningful error messages to users
```

### Issue 3: State Management Brittleness
**Severity**: MEDIUM  
**Impact**: Hard to debug, difficult to refactor

**Current State**:
- RecipeForm manages recipe state
- AddIngredientForm modifies ingredient_list directly
- IngredientList.svelte mutates on drag-drop
- SectionList.svelte creates temporary IDs
- Multiple places track `_localIndex`

**Solution**:
```
1. Centralize recipe state in one store/context
2. Create immutable update functions
3. Validate all state transitions
4. Use stable keys (not _localIndex)
5. Make state flow unidirectional (parent → child props)
```

### Issue 4: Duplicate Data Transformation Logic
**Severity**: MEDIUM  
**Impact**: Maintenance burden, inconsistency risks

**Current State**:
- `getRecipeWithIngredients()` normalizes and groups data
- GET `/api/recipes` does similar grouping
- Both parse extensions as comma-separated strings
- Both sort sections and ingredients by ordering

**Solution**:
```
1. Extract data transformation into reusable functions
2. Create data normalization module
3. Define single source of truth for data shape
4. Test transformations independently
```

### Issue 5: Missing Type Safety & Documentation
**Severity**: MEDIUM  
**Impact**: Silent bugs, harder to refactor

**Current State**:
- No TypeScript
- Minimal JSDoc comments
- API contracts not documented
- Component prop shapes unclear

**Solution**:
```
Options:
A) Migrate to TypeScript (larger effort)
B) Add comprehensive JSDoc annotations (pragmatic)
C) Create TypeScript-adjacent validation (hybrid)

Recommended: Start with option B + C
- Add JSDoc to all functions
- Create .d.ts files for external APIs
- Add runtime validation to entry points (API handlers, component inputs)
```

### Issue 6: Component Coupling & Testability
**Severity**: MEDIUM  
**Impact**: Hard to test, brittle changes

**Current State**:
- IngredientList tightly coupled to ingredient data structure
- Drag-drop logic embedded in component
- Hard to test without full parent context
- Global units context dependency

**Solution**:
```
1. Extract drag-drop logic into separate utility
2. Create reusable list component that's data-agnostic
3. Inject dependencies (units context)
4. Write tests for transformations and handlers
5. Use component stories/examples
```

### Issue 7: No Transaction Support
**Severity**: MEDIUM  
**Impact**: Partial failures possible, data inconsistency

**Current State**:
```javascript
// recipe-operations.js - Multiple separate operations
await upsertSections(...);
await upsertIngredients(...);  // If this fails, sections are orphaned
await upsertExtensions(...);
await upsertAlternates(...);
```

**Solution**:
```
1. Wrap multi-operation functions in database transactions
2. Drizzle supports transactions via .transaction()
3. Ensures all-or-nothing updates
4. Reduces edge cases
```

---

## Implementation Plan

### Phase 1: Foundation (Weeks 1-2)
**Goal**: Establish safety infrastructure

#### 1.1 Add Validation Layer
- [ ] Create `src/lib/validation/schemas.js` with validation functions
- [ ] Define schemas for Recipe, Ingredient, Section, Alternate, Extension
- [ ] Add validation middleware to API handlers
- [ ] Return detailed error responses with field-level feedback
- [ ] Test: Manual API testing with invalid inputs

#### 1.2 Add Error Handling Infrastructure
- [ ] Create `src/lib/components/ErrorBoundary.svelte`
- [ ] Create `src/lib/toast/notifications.js` (or use existing library)
- [ ] Add error handling to all API calls
- [ ] Add toast/notification system for user feedback
- [ ] Add loading states to forms
- [ ] Test: Simulate network errors, constraint violations

#### 1.3 Add Test Infrastructure
- [ ] Install Vitest + @vitest/ui
- [ ] Create test directory structure: `src/__tests__/`
- [ ] Write first test file for validation schemas
- [ ] Document testing workflow in README
- [ ] Test: Run tests locally, confirm setup works

**Deliverables**:
- Validation schemas working end-to-end
- Error messages visible in UI
- Test runner configured and first tests passing
- Documentation updated with error handling guidelines

---

### Phase 2: Data Layer Robustness (Weeks 2-3)
**Goal**: Make data operations safe and consistent

#### 2.1 Add Transaction Support
- [ ] Refactor `recipe-operations.js` to use transactions
- [ ] Wrap `createRecipe()` and `updateRecipe()` in transactions
- [ ] Add rollback documentation
- [ ] Test: Verify failed operations don't partially succeed

#### 2.2 Consolidate Data Normalization
- [ ] Create `src/lib/server/data-transforms.js`
- [ ] Extract `normalizeRecipe()` function (used by both endpoints)
- [ ] Extract `groupIngredientsBySection()` function
- [ ] Extract `parseExtensions()` function
- [ ] Update both endpoints to use shared functions
- [ ] Test: Compare outputs of both endpoints for same recipe

#### 2.3 Add JSDoc Type Annotations
- [ ] Add JSDoc to all functions in recipe-operations.js
- [ ] Add JSDoc to data-transforms.js
- [ ] Add JSDoc to API handlers
- [ ] Document prop shapes in components (at least major ones)
- [ ] Test: Use IDE type checking (JSDoc support)

**Deliverables**:
- No more silent partial failures
- Single source of truth for data transforms
- Clear type documentation for functions
- Tests for transaction behavior

---

### Phase 3: State Management & Components (Weeks 3-4)
**Goal**: Make components safer and more testable

#### 3.1 Refactor State Management
- [ ] Create `src/lib/stores/recipe.js` for centralized recipe state
- [ ] Move recipe state from RecipeForm to store
- [ ] Create immutable update functions
- [ ] Add state validation
- [ ] Update RecipeForm to use store instead of props
- [ ] Test: Verify all state mutations go through store

#### 3.2 Extract Reusable Utilities
- [ ] Extract drag-drop logic from IngredientList.svelte → `src/lib/utils/drag-drop.js`
- [ ] Extract list rendering logic → `src/lib/components/DraggableList.svelte`
- [ ] Create utility for section ID resolution
- [ ] Replace `_localIndex` with stable keys
- [ ] Test: List reordering still works

#### 3.3 Add Component Tests
- [ ] Write tests for AddIngredientForm validation
- [ ] Write tests for ingredient list mutations
- [ ] Write tests for section assignment logic
- [ ] Create component story examples for UI testing
- [ ] Test: Components render and update correctly in isolation

#### 3.4 Improve Error Recovery
- [ ] Add optimistic UI updates
- [ ] Implement rollback on failure
- [ ] Add retry mechanism for failed saves
- [ ] Show conflict resolution UI if needed
- [ ] Test: Force failures and verify recovery

**Deliverables**:
- Centralized recipe state store
- Components easier to test in isolation
- Stable component tests
- Better user feedback during errors

---

### Phase 4: Polish & Documentation (Week 4-5)
**Goal**: Make codebase maintainable and developer-friendly

#### 4.1 Complete Test Coverage
- [ ] Add tests for all API endpoints
- [ ] Add tests for data transforms
- [ ] Add tests for validation schemas
- [ ] Aim for 80%+ coverage of business logic
- [ ] Document testing best practices

#### 4.2 Improve Documentation
- [ ] Document API contracts (input/output shapes)
- [ ] Document error codes and meanings
- [ ] Add architecture diagram to README
- [ ] Document state management flow
- [ ] Create troubleshooting guide

#### 4.3 Code Quality Tools
- [ ] Add ESLint configuration
- [ ] Add Prettier for formatting
- [ ] Add pre-commit hooks (husky)
- [ ] Document code style guidelines
- [ ] Run linter on existing code, fix issues

#### 4.4 Performance Baseline
- [ ] Document current performance (load times)
- [ ] Identify bottlenecks
- [ ] Create performance monitoring
- [ ] Add tests for performance regressions

**Deliverables**:
- >80% test coverage for business logic
- Comprehensive documentation
- Code quality tooling configured
- Performance baseline documented

---

### Phase 5: Future Enhancements (Optional)
**Goal**: Advanced features for production readiness

#### 5.1 Concurrency & Conflict Resolution
- [ ] Implement optimistic locking (version field in recipes)
- [ ] Add conflict detection and resolution UI
- [ ] Handle race conditions in multi-user scenarios

#### 5.2 Audit Trail & Recovery
- [ ] Add recipe change history table
- [ ] Implement undo/redo functionality
- [ ] Create audit log viewer

#### 5.3 Advanced Validation
- [ ] Add cross-field validation (e.g., ingredient exists before using)
- [ ] Add business rule validation (e.g., min temp requirements)
- [ ] Create admin validation dashboard

#### 5.4 Migration to TypeScript (Optional)
- [ ] Migrate critical files: schema, operations, validations
- [ ] Generate types from Drizzle schema
- [ ] Add type checking to build pipeline

---

## Task Checklist by Priority

### 🔴 High Priority (Do First)
- [ ] Add validation schemas for all inputs
- [ ] Add error handling to all API endpoints
- [ ] Add error boundaries and toast notifications
- [ ] Install and configure test framework
- [ ] Document API contracts

### 🟡 Medium Priority (Do Next)
- [ ] Add transaction support to recipe operations
- [ ] Consolidate data normalization functions
- [ ] Add JSDoc type annotations
- [ ] Write tests for critical paths
- [ ] Refactor component state management

### 🟢 Low Priority (Polish Phase)
- [ ] Extract reusable utilities
- [ ] Add component tests
- [ ] Add ESLint/Prettier
- [ ] Create performance monitoring
- [ ] Consider TypeScript migration

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|-----------|
| Data corruption from invalid inputs | High | Critical | ✅ Add validation layer (Phase 1) |
| Partial failures in multi-operation updates | Medium | High | ✅ Add transactions (Phase 2) |
| Silent bugs from type mismatches | Medium | Medium | ✅ Add JSDoc + tests (Phase 2-3) |
| Component state inconsistencies | Medium | Medium | ✅ Centralize state (Phase 3) |
| Hard to debug production issues | Medium | Medium | ✅ Add error tracking (Phase 4) |
| Performance regression with users | Low | Medium | ✅ Add monitoring (Phase 4) |

---

## Metrics & Success Criteria

### By End of Phase 1
- ✅ All API endpoints have input validation
- ✅ All errors show user-friendly messages
- ✅ Test suite runs successfully
- ✅ 0 unhandled promise rejections in console

### By End of Phase 2
- ✅ 100% of multi-step operations use transactions
- ✅ Data normalization DRY (no duplication)
- ✅ All public functions have JSDoc
- ✅ Data transforms have 90%+ test coverage

### By End of Phase 3
- ✅ No prop drilling beyond 2 levels deep
- ✅ All components can be tested in isolation
- ✅ 80%+ of business logic has tests
- ✅ No store mutations outside store module

### By End of Phase 4
- ✅ >80% test coverage overall
- ✅ All APIs documented in README or API guide
- ✅ Linter passes with 0 warnings
- ✅ Performance baselines established

---

## Implementation Order

**Suggested execution path** (maximize value early):

1. **Week 1**: Validation + Error Handling (Phase 1.1-1.2)
2. **Week 2**: Test Infrastructure + Transactions (Phase 1.3 + 2.1)
3. **Week 3**: Data Normalization + JSDoc (Phase 2.2-2.3)
4. **Week 4**: State Management (Phase 3.1-3.2)
5. **Week 5**: Component Tests + Polish (Phase 3.3-4.3)

This order ensures:
- Users get immediate error feedback (Week 1)
- Critical data operations are safe (Week 2)
- Codebase is well-documented (Week 3)
- Components are maintainable (Week 4-5)

---

## Estimated Effort

| Phase | Estimated Hours | Priority |
|-------|-----------------|----------|
| 1. Foundation | 16-20 | 🔴 High |
| 2. Data Layer | 12-16 | 🔴 High |
| 3. Components | 16-20 | 🟡 Medium |
| 4. Polish | 12-16 | 🟡 Medium |
| 5. Advanced | 20+ | 🟢 Low |
| **Total** | **76-92 hours** | - |

**Part-time estimate**: 4-5 weeks @ 20 hrs/week

---

## Quick Wins (Start Today)

These can be done in 2-3 hours and provide immediate value:

1. Add `try-catch` with detailed error messages to 3 main API handlers
2. Create simple toast notification component
3. Add 5-10 JSDoc comments to `recipe-operations.js`
4. Create first validation schema file with one schema
5. Install Vitest and write one passing test

---

## Next Steps

1. **Review this plan** - Does it align with your goals?
2. **Prioritize phases** - Do you want to follow this order?
3. **Assign tasks** - Which phase do you want to start with?
4. **Create sprint** - Convert tasks to actionable items

Would you like me to start with **Phase 1** (validation + error handling)? That will provide immediate safety improvements and establish the testing foundation.
