<script>
	import DraggableRecipeList from './DraggableRecipeList.svelte';
	import RecipeSortControls from './RecipeSortControls.svelte';
	import RecipeSearchFilter from './RecipeSearchFilter.svelte';
	import { fade, slide } from 'svelte/transition';

	let { selectedRecipeIds = $bindable([]), allRecipes = [], onRecipesChange } = $props();

	let searchTerm = $state('');

	function handleSearch(term) {
		searchTerm = term;
	}

	function handleSort(newOrder) {
		selectedRecipeIds = newOrder;
		onRecipesChange?.(selectedRecipeIds);
	}

	function handleReorder(newIds) {
		selectedRecipeIds = newIds;
		onRecipesChange?.(selectedRecipeIds);
	}

	function getAvailableRecipes() {
		const selected = new Set(selectedRecipeIds);
		return allRecipes
			.filter((r) => !selected.has(r.id))
			.filter(
				(r) =>
					!searchTerm ||
					(r.title || '').toLowerCase().includes(searchTerm.toLowerCase())
			);
	}

	function toggleRecipeSelection(recipeId, isSelected) {
		if (isSelected) {
			selectedRecipeIds = [...selectedRecipeIds, recipeId];
		} else {
			selectedRecipeIds = selectedRecipeIds.filter((id) => id !== recipeId);
		}
		onRecipesChange?.(selectedRecipeIds);
	}
</script>


<div class="recipe-selector">
	
	<div class="selector-header">
		<h3>Select & Order Recipes</h3>
		<span class="recipe-count">{selectedRecipeIds.length} selected</span>
	</div>
	
		<!-- Selected Recipes Section -->
		{#if selectedRecipeIds.length > 0}
		<div class="selected-recipes-section">
			<h4>Selected Recipes ({selectedRecipeIds.length})</h4>
			<RecipeSortControls
			{selectedRecipeIds}
			{allRecipes}
			onSort={handleSort}
			/>
			<DraggableRecipeList
			bind:selectedRecipeIds
			{allRecipes}
			onReorder={handleReorder}
			/>
		</div>
		{/if}
		
		<!-- Available Recipes Section -->
		<div class="available-recipes-section">
			<h4>Available Recipes ({getAvailableRecipes().length})</h4>
			<RecipeSearchFilter bind:searchTerm onSearch={handleSearch} />

			<div class="available-recipes-list">
				{#if getAvailableRecipes().length === 0}
					<p class="empty-state">
						{#if searchTerm}
							No recipes match "{searchTerm}"
						{:else if selectedRecipeIds.length === allRecipes.length}
							All recipes are selected!
						{:else}
							No recipes available
						{/if}
					</p>
				{:else}
					{#each getAvailableRecipes() as recipe (recipe.id)}
						<label 
							class="recipe-checkbox-item"
							in:fade={{ duration: 200 }}
							out:fade={{ duration: 200 }}
						>
							<input
								type="checkbox"
								checked={false}
								onchange={(e) => {
									e.stopPropagation();
									toggleRecipeSelection(recipe.id, e.target.checked);
								}}
							/>
							<span class="recipe-name">{recipe.title}</span>
						</label>
					{/each}
				{/if}
			</div>
		</div>
</div>
<style lang="scss">
	.recipe-selector {
		display: flex;
		flex-direction: column;
		
		
		background: #fafafa;
		border-radius: 6px;
		border: 1px solid #e0e0e0;

		display:grid;
		gap:1.5rem;
		grid-template-columns: 1fr;
		@media (min-width: 768px) {
			grid-template-columns: 1fr 1fr;
			
			
		}
	}

	.selector-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 0.5em;
		grid-column: 1 / -1;
		h3 {
			margin: 0;
			font-size: 1.2em;
			color: #333;
		}

		.recipe-count {
			background: #2196f3;
			color: white;
			padding: 0.2em 0.6em;
			border-radius: 12px;
			font-size: 0.9em;
			font-weight: 600;
		}
	}

	.selected-recipes-section {
		padding: 1em;
		background: white;
		border-radius: 6px;
		border: 1px solid #e0e0e0;
		

		h4 {
			margin: 0 0 1em 0;
			color: #333;
			font-size: 1em;
		}
	}

	.available-recipes-section {
		padding: 1em;
		background: white;
		border-radius: 6px;
		border: 1px solid #e0e0e0;

		h4 {
			margin: 0 0 1em 0;
			color: #333;
			font-size: 1em;
		}
	}

	.available-recipes-list {
		display: flex;
		flex-direction: column;
		gap: 0.5em;
		max-height: 100vh;
		overflow-y: auto;
		padding: 0.5em;
	}

	.recipe-checkbox-item {
		display: flex;
		align-items: center;
		gap: 0.75em;
		padding: 0.5em;
		border-radius: 4px;
		cursor: pointer;
		transition: background 150ms ease-out;

		&:hover {
			background: #f5f5f5;
		}

		input[type='checkbox'] {
			cursor: pointer;
		}

		.recipe-name {
			flex: 1;
			word-break: break-word;
		}
	}

	.empty-state {
		padding: 2em 1em;
		text-align: center;
		color: #999;
		font-style: italic;
	}
</style>
