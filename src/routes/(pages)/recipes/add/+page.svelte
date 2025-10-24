<script>
    import { page } from '$app/stores';
    import { get } from 'svelte/store';
    import { onMount, setContext } from 'svelte';
    import RecipeForm from '../RecipeForm.svelte';
    import { recipeStore } from '$lib/stores/recipeStore.js';
    import '$lib/components/recipe_form/recipe_styles.scss';
    
    let data = get(page).data;
    let {all_ingredients, units, extensions} = data;

    setContext("all_ingredients", all_ingredients);
    setContext("units", units);
    setContext("extensions", extensions);

    // Initialize blank recipe on mount
    onMount(async () => {
        recipeStore.blank();
    });
</script>

<RecipeForm />