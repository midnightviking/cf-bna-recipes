<script>
	import Fab from "@smui/fab";
	import Button, { Icon, Label } from "@smui/button";
	import { goto, invalidate } from "$app/navigation";
	import Editable from "$lib/components/Editable.svelte";
	import RecipeFormDialog from "./RecipeFormDialog.svelte";
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import DataTable, { Body, Cell, Head, Row } from "@smui/data-table";
	import { mdiPlus } from "@mdi/js";
	import { getContext, onMount, setContext } from "svelte";
	
	let { data } = $props();
	let recipes = $derived(data.recipes);
	let showform = $state(false);
	let { units, ingredients } = data;

	
	let recipe_to_edit = $state({});
	function openForm(recipe = {}) {
		recipe_to_edit = recipe;
		showform = true;
	}

	const closeForm = () => {
		showform = false;
		recipe_to_edit = {};
	};

	async function afterSave() {
		await invalidate("app:recipes");
		closeForm();
	}

	async function deleteRecipe(index) {
		const recipe = recipes[index];
		if (confirm(`Really delete ${recipe.title}?`)) {
			if (recipe.id) {
				await fetch("/api/recipes", {
					method: "DELETE",
					headers: { "Content-Type": "application/json" },
					body: JSON.stringify({ id: recipe.id }),
				});
				await invalidate("app:recipes");
			}
		}
	}

	import { useBannerActions } from "$lib/action-banner-state.svelte.js";

	const banner_actions = [
		{ label: "Add Recipe", icon: "", func: () => { goto('recipes/add'); } }
	];

	useBannerActions(banner_actions);

</script>

<Fab
	extended
	type="button"
	onclick={() => {
		goto('recipes/add');
	}}
	style="position:fixed; right:0; bottom:20px; z-index:7"
>
	<Icon tag="svg" viewBox="0 0 24 24">
		<path fill="currentColor" d={mdiPlus} />
	</Icon>
	<Label>Add Recipe</Label>
</Fab>

<!-- Destroying the form and recreating it, for now. Better binding on the inputs will avoid this in the future -->
{#key showform}
	<RecipeFormDialog
        open={showform}
		allIngredients={ingredients}
		{units}
		itemType={recipe_to_edit.itemType?.toLowerCase()}
		category={recipe_to_edit.category?.toLowerCase()}
		{closeForm}
		{...recipe_to_edit}
		{afterSave}
	/>
{/key}

<h1>Recipes</h1>
<div class="recipe-list">
	{#if recipes?.length === 0}
		<p>No recipes found.</p>
	{/if}
	{#each recipes as recipe, i}
    
		<Editable
			title={recipe.title}
			onEdit={() => goto(`/recipes/edit/${recipe.id}`)}
			onDelete={() => deleteRecipe(i)}
		>
			<div class="recipe-view">
				<div class="recipe-info">
					<ul>
						<li>
							<strong>Category:</strong>
							{recipe?.category}
						</li>
						<li>
							<strong>Min Temp:</strong>
							{recipe?.minTemp}
						</li>
						<li>
							<strong>Item Type:</strong>
							{recipe?.itemType}
						</li>
						<li>
							<strong>Portion Size:</strong>
							{recipe?.portionSize}
						</li>
						<li>
							<strong>Calories:</strong>
							{recipe?.calories}
						</li>
						<li>
							<strong>Protein:</strong>
							{recipe?.protein}
						</li>
						<li>
							<strong>Initial Servings:</strong>
							{recipe?.initialServings}
						</li>
					</ul>
				</div>
				<div class="recipe-ingredients">
					<DataTable>
						<Head>
							<Row>
								<Cell>Ingredient</Cell>
								<Cell>Quantity</Cell>
								<Cell>Unit</Cell>
							</Row>
						</Head>
						<Body>
							{#each recipe?.ingredients as ingredient}
								<Row>
									<Cell>
										{ingredient?.name}
									</Cell>
									<Cell>
										{ingredient?.quantity}
									</Cell>
									<Cell>
										{ingredient?.unit_name}
									</Cell>
								</Row>
							{/each}
						</Body>
					</DataTable>
				</div>
				<div class="recipe-substitutions">
					<strong>Substitutions</strong><br />
					{recipe?.substitutions}
				</div>
				<div class="recipe-instructions">
					<strong>Instructions</strong><br />
					{recipe?.instructions}
				</div>
			</div>
		</Editable>
	{/each}
</div>

<style lang="scss">
	.recipe-list {
		margin-bottom: 2rem;
	}
	.recipe-form {
		padding: 0.5rem 1.5rem;
		/* background: #fafafa;
        border: 1px solid #ddd;
        border-radius: 6px;
        max-width: 700px;
        margin-top: 2rem; */
	}
	* :global(.mdc-select),
	* :global(.mdc-text-field) {
		margin-bottom: 1rem;
		width: 100%;
	}

	:global(.editable-card) {
		margin-bottom: 2rem;
		border:#ebebeb .25rem solid;
	}

	.recipe-view {
		display: flex;
		gap: 1rem;
		flex-direction: column;
		white-space: pre-line;
		margin-bottom: 1rem;
		
		.recipe-info {
			ul {
				margin: 0;
				padding: 0;
				display: grid;
				grid-template-columns: auto 1fr;
				list-style: none;
				gap: 0.5rem 1.5rem;
			}
		}
	}

	* :global(.mdc-data-table__row) {
		&:nth-child(even) {
			background: rgba(0, 0, 0, 0.1);
		}
	}
</style>
