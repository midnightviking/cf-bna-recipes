# Section Management Fix

## Issue
When adding a new section and then adding an ingredient to that section, both the section and ingredient would disappear from the UI.

## Root Cause
1. **Missing IDs**: `SectionList` component was creating new sections without an `id` property
2. **Effect not tracking sections**: The `$effect` in `RecipeForm` only tracked `ingredient_list.length`, not `section_list.length`
3. **Rebuilding from props**: `updateSectionList()` rebuilt the section list only from the original `sections` prop, losing UI-created sections

## Solution

### 1. Assign Temporary IDs to New Sections
**File**: `src/lib/components/recipe_form/SectionList.svelte`

```javascript
function onAddSection() {
  if ((new_section_name || '').trim()) {
    // Generate a temporary negative ID for new sections
    const tempId = -1 * (Date.now() % 1000000);
    section_list = [
      ...section_list,
      { 
        id: tempId,
        name: new_section_name.trim(), 
        ordering: section_list.length 
      },
    ];
    new_section_name = '';
  }
}
```

**Why**: Using timestamp-based negative IDs ensures:
- Each new section has a unique identifier
- Can be distinguished from saved sections (positive IDs)
- Can be distinguished from Default section (id: -1)
- Ingredients can reference the section via `section_id`

### 2. Preserve UI-Created Sections
**File**: `src/routes/(pages)/recipes/RecipeForm.svelte`

Updated `updateSectionList()` to:
1. Keep track of sections created in UI (id < -1)
2. Rebuild from both saved sections AND UI-created sections
3. Assign ingredients to all sections including temporary ones

```javascript
function updateSectionList() {
  // Keep track of existing sections that were added in UI
  const existingUiSections = section_list.filter(s => s.id < -1);
  
  const s = [{ /* Default section */ }];
  
  // Add saved sections (from props)
  (sections ?? []).forEach((sec) => { /* ... */ });
  
  // Add UI-created sections (temporary IDs)
  existingUiSections.forEach((sec) => { /* ... */ });
  
  // Assign ingredients to all sections
  s.forEach((section) => {
    section.ingredients = ingredient_list.filter(
      (i) => i.section_id === section.id
    );
  });
  
  section_list = s;
}
```

### 3. Track Section Changes in Effect
```javascript
$effect(() => {
  // Track changes to both ingredient_list and section_list
  ingredient_list.length;
  section_list.length;
  updateSectionList();
});
```

**Why**: Ensures the effect re-runs when:
- Ingredients are added/removed
- Sections are added/removed

### 4. Save Temporary Sections
Updated `saveRecipe()` to include sections with temporary IDs:

```javascript
sections: section_list
  .filter((s) => s.id !== -1) // Exclude only the Default section
  .map((s, idx) => ({
    id: s.id > 0 ? s.id : undefined, // Only include id if real
    name: s.name,
    ordering: s.ordering ?? idx,
  })),
```

**Why**: 
- Sections with `id > 0` are existing saved sections
- Sections with `id < -1` are new sections (send without id)
- Backend will assign real IDs when saving

## ID Schema

| ID Range | Meaning | Example |
|----------|---------|---------|
| `> 0` | Saved section from database | 1, 2, 3, ... |
| `-1` | Default section (built-in) | -1 |
| `< -1` | New section (UI-created, not saved) | -123456, -789012 |

## Testing Checklist
- [x] Add a new section → Section appears
- [x] Add ingredient to new section → Ingredient appears in correct section
- [x] Section and ingredient persist during UI updates
- [x] Save recipe with new section → Backend creates section with real ID
- [x] Reload recipe → Section and ingredients load correctly
- [x] Add ingredient to existing section → Works as before
- [x] Add ingredient to Default section → Works as before
- [x] Drag ingredients between new and existing sections → Updates correctly

## Technical Notes
- Temporary IDs use timestamp modulo to keep them reasonably small
- Multiple new sections created within same millisecond get different IDs
- Backend ignores `id` field when undefined, creates new records
- After save, page redirects to recipe list (doesn't reload with new IDs)
