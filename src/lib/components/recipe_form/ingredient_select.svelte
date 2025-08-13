<div>

	<Autocomplete
	options={allIngredients}
	key={(ing)=>`${ing? ing.id: ''}`}
	
	getOptionLabel={(opt)=> opt? `${opt.name}`:''}
	bind:value
	style="width: 100%;"
	textfield$style="width: 100%;"
	label={label}
	/>
	
	
</div>

<script>
	import Autocomplete from "@smui-extra/autocomplete";
	import Textfield from "@smui/textfield";
	import { getContext } from "svelte";

	let {
		// value is the selected ingredient object (null when none)
		value=$bindable(null),
		label="Select Ingredient"
	} = $props();

	const allIngredients = getContext("all_ingredients")
	
</script>