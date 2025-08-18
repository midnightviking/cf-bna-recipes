<script>
	import CookbookForm from '../../CookbookForm.svelte';
    import {setContext} from 'svelte';
    
    let { data } = $props();
    let {cookbook, recipes} = data;
    
    setContext("all_recipes", recipes);

</script>
{#if cookbook}

    <div class="cookbook-form">
		<h2>Edit {cookbook?.name}</h2>
		<CookbookForm
            {...cookbook}
            />
        
	</div>
{/if}