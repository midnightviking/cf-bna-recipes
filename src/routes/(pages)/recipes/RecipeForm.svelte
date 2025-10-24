<script>
	import { goto } from "$app/navigation";
	import { get } from "svelte/store";
	import { useBannerActions } from "$lib/action-banner-state.svelte";
	import { recipeStore } from "$lib/stores/recipeStore.js";
	import { showSuccess, showErrorFromResponse } from "$lib/services/toast.js";
	import RecipeMetaFields from "$lib/components/recipe_form/RecipeMetaFields.svelte";
	import SectionList from "$lib/components/recipe_form/SectionList.svelte";
	import IngredientList from "$lib/components/recipe_form/IngredientList.svelte";
	import AlternatesEditor from "$lib/components/recipe_form/AlternatesEditor.svelte";
	import AddIngredientForm from "$lib/components/recipe_form/AddIngredientForm.svelte";
	import RfExtensions from "$lib/components/recipe_form/rf_extensions.svelte";

	// Destructure stores from recipeStore object
	// These are actual Svelte stores that can be used with $ prefix
	const { recipe, ingredients, sectionsByIngredient, alternates, isValid } = recipeStore;

	async function saveRecipe() {
		try {
			await recipeStore.save();
			showSuccess("Recipe saved successfully!");
			goto("/recipes");
		} catch (error) {
			showErrorFromResponse(error);
		}
	}

	const banner_actions = [
		{ 
			label: get(recipeStore.recipe).id ? "Update" : "Save", 
			icon: "", 
			func: saveRecipe 
		},
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

<h3>{$recipe.id ? `Edit ${$recipe.title}` : "Add"} Recipe</h3>
<div id="recipe-dialog-content">
	<div class="recipe-form" style="width:100%;">
		<!-- Recipe Name Row-->

		<RecipeMetaFields
			title={$recipe.title}
			itemType={$recipe.itemType}
			category={$recipe.category}
			portionSize={$recipe.portionSize}
			calories={$recipe.calories}
			protein={$recipe.protein}
			minTemp={$recipe.minTemp}
			instructions={$recipe.instructions}
			ccp={$recipe.ccp}
			substitutions={$recipe.substitutions}
			initialServings={$recipe.initialServings}
		/>
		
		
		<AddIngredientForm />
		
		<div class="recipe-ingredient-list">
			{#each $sectionsByIngredient as section}
				<h4>{section?.name}</h4>
				<IngredientList
					{section}
				/>
				{/each}
			<SectionList />
		</div>
		
			<RfExtensions recipe_id={$recipe.id} ingredients={$ingredients} alternates={$alternates} />
		
	</div>
</div>

<style lang="scss">
</style>
