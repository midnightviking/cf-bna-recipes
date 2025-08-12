<script>
    import { page } from '$app/stores';
    import { get } from 'svelte/store';
    import RecipeForm from '../RecipeForm.svelte';
	import { onMount, setContext } from 'svelte';
	
    
    let data = get(page).data;
    let {all_ingredients, units, extensions} = data;

    setContext("all_ingredients", all_ingredients);
    setContext("units", units);
    setContext("extensions", extensions);
    
    
</script>

<RecipeForm
    
/>