<script>
    import { page } from '$app/stores';
    import { get } from 'svelte/store';
    import { onMount, setContext } from 'svelte';
    import RecipeForm from '../../RecipeForm.svelte';
    import { recipeStore } from '$lib/stores/recipeStore.js';
    import { showError } from '$lib/services/toast.js';
    import '$lib/components/recipe_form/recipe_styles.scss';
    
    let id = get(page).params.id;
    let data = get(page).data;
    let {recipe, all_ingredients, units, extensions} = data;

    setContext("all_ingredients", all_ingredients);
    setContext("units", units);
    setContext("extensions", extensions);

    // Load recipe into store on mount
    onMount(async () => {
        try {
            if (recipe && recipe.id) {
                // Set the recipe data in the store
                recipeStore.setRecipe({
                    id: recipe.id,
                    title: recipe.title,
                    itemType: recipe.itemType?.toLowerCase() ?? "",
                    category: recipe.category?.toLowerCase() ?? "",
                    portionSize: recipe.portionSize,
                    calories: recipe.calories,
                    protein: recipe.protein,
                    minTemp: recipe.minTemp,
                    instructions: recipe.instructions,
                    ccp: recipe.ccp,
                    substitutions: recipe.substitutions,
                    initialServings: recipe.initialServings,
                });
                
                // Load ingredients, sections, and alternates
                if (recipe.ingredients) {
                    recipe.ingredients.forEach(ing => {
                        recipeStore.addIngredient({
                            ingredient_id: ing.ingredient_id,
                            quantity: ing.quantity,
                            unit_id: ing.unit_id,
                            section_id: ing.section_id
                        });
                    });
                }
                
                if (recipe.sections) {
                    recipe.sections.forEach(sec => {
                        recipeStore.addSection({
                            id: sec.id,
                            name: sec.name,
                            ordering: sec.ordering
                        });
                    });
                }
                
                if (recipe.alternates) {
                    recipe.alternates.forEach(alt => {
                        recipeStore.addAlternate({
                            original_ingredient: alt.original_ingredient,
                            alternate_ingredient: alt.alternate_ingredient,
                            quantity: alt.quantity,
                            unit_id: alt.unit_id,
                            extensions: alt.extensions
                        });
                    });
                }
            }
        } catch (error) {
            showError(error.message);
        }
    });
</script>

<RecipeForm />