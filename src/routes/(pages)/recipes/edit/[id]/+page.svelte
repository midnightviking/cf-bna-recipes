<script>
    import { page } from '$app/stores';
    import { get } from 'svelte/store';
    import RecipeForm from '../../RecipeForm.svelte';
	import { onMount, setContext } from 'svelte';
    let id = get(page).params.id;
    let data = get(page).data;
    let {recipe, all_ingredients, units, extensions} = data;
    recipe.itemType = recipe.itemType?.toLowerCase() ?? ""
    recipe.category = recipe.category?.toLowerCase() ?? "";
    let alternates = $state(recipe.alternates);

    setContext("all_ingredients", all_ingredients);
    setContext("units", units);
    setContext("extensions", extensions);
    // $inspect(alternates)
    
</script>

<RecipeForm
    {...recipe}
    alternates={alternates}
/>