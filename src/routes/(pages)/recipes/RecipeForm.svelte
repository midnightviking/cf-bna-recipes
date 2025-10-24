<script>
	import { goto } from "$app/navigation";
	import { untrack } from "svelte";
	import { useBannerActions } from "$lib/action-banner-state.svelte";
	import RecipeMetaFields from "$lib/components/recipe_form/RecipeMetaFields.svelte";
	import SectionList from "$lib/components/recipe_form/SectionList.svelte";
	import IngredientList from "$lib/components/recipe_form/IngredientList.svelte";
	import AlternatesEditor from "$lib/components/recipe_form/AlternatesEditor.svelte";
	import AddIngredientForm from "$lib/components/recipe_form/AddIngredientForm.svelte";
	import RfExtensions from "$lib/components/recipe_form/rf_extensions.svelte";

	let new_section_name = $state("");
	
	let {
		id = null,
		title = "",
		minTemp = "",
		itemType = "",
		portionSize = "",
		calories = "",
		protein = "",
		category = "",
		instructions = "",
		ccp = "",
		substitutions = "",
		initialServings = 100,
		ingredients = [],
		sections = [],
		alternates = [],
	} = $props();

	let _localIndex = $state(0);
	let realSectionIds = new Set((sections ?? []).map((s) => s.id));
	let ingredient_list = $state(
		(ingredients ?? []).map((i) => ({
			...i,
			section_id:
				i.section_id != null && realSectionIds.has(i.section_id)
					? i.section_id
					: -1,
			_localIndex: _localIndex++,
		}))
	);

	// Initialize section_list once from props
	let section_list = $state([
		{
			ordering: -1,
			name: "Default",
			id: -1,
			ingredients: [],
		},
		...(sections ?? []).map((sec) => ({
			...sec,
			ordering: sec.ordering ?? 0,
			ingredients: [],
		}))
	]);

	$effect(() => {
		// Update section ingredients when ingredient_list changes
		// Track ingredient_list to detect changes
		const ingredients = ingredient_list;
		
		// Update ingredients for each section without recreating section_list
		for (const section of section_list) {
			section.ingredients = ingredients.filter(
				(i) => i.section_id === section.id
			);
		}
	});

	async function saveRecipe() {
		const recipe = {
			id: id ? id : undefined,
			title,
			minTemp,
			itemType,
			portionSize,
			calories,
			protein,
			category,
			instructions,
			ccp,
			substitutions,
			initialServings,
			ingredients: ingredient_list.map((i, idx) => ({
				id: i.id,
				ingredient_id: i.ingredient_id,
				quantity: i.quantity,
				unit_id: i.unit_id,
				ordering: i.ordering ?? idx,
				section_id: (i.section_id && i.section_id > 0) ? i.section_id : null,
			})),
			sections: section_list
				.filter((s) => s.id !== -1) // Exclude only the Default section
				.map((s, idx) => ({
					id: s.id > 0 ? s.id : undefined, // Only include id if it's a real (positive) ID
					name: s.name,
					ordering: s.ordering ?? idx,
				})),
			alternates: alternates.map((a) => ({ ...a })),
		};

		const method = id ? "PUT" : "POST";
		try {
			const response = await fetch("/api/recipes", {
				method,
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(recipe),
			});

			if (response.ok) {
				goto("/recipes");
			} else {
				const errorData = await response.json();
				console.error("Save failed:", errorData);
				alert(`Failed to save recipe: ${errorData.error || 'Unknown error'}`);
			}
		} catch (error) {
			console.error("Save error:", error);
			alert(`Failed to save recipe: ${error.message}`);
		}
	}

	const banner_actions = [
		{ label: id ? "Update" : "Save", icon: "", func: saveRecipe },
		{
			label: "Cancel",
			icon: "",
			func: () => {
				goto(history.back());
			},
		},
	];

	useBannerActions(banner_actions);
</script>

<h3>{id ? `Edit ${title}` : "Add"} Recipe</h3>
<div id="recipe-dialog-content">
	<div class="recipe-form" style="width:100%;">
		<!-- Recipe Name Row-->

		<RecipeMetaFields
			{title}
			{itemType}
			{category}
			{portionSize}
			{calories}
			{protein}
			{minTemp}
			{instructions}
			{ccp}
			{substitutions}
			{initialServings}
		/>
		
		
		<AddIngredientForm 
			bind:section_list 
			bind:ingredient_list 
			bind:_localIndex 
		/>
		
		<div class="recipe-ingredient-list">
			{#each section_list as section}
				<h4>{section?.name}</h4>
				<IngredientList
					{section}
					bind:ingredient_list
				/>
				{/each}
			<SectionList bind:section_list bind:ingredient_list bind:new_section_name />
		</div>
		
			<RfExtensions recipe_id={id} {ingredient_list} {alternates} />
		
	</div>
</div>

<style lang="scss">
</style>
