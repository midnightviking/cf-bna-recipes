<script>
	import { onMount } from 'svelte';
	import Sortable from 'sortablejs';
	import { recipeStore } from '$lib/stores/recipeStore.js';
	import { showError } from '$lib/services/toast.js';
	import List from "@smui/list";
	import IngredientItem from "./IngredientItem.svelte";
	
	let { section } = $props();
	
	// Destructure stores
	const { ingredients, sectionsByIngredient } = recipeStore;
	
	let ingSelected = $state(null);
	let containerEl;

	onMount(() => {
		if (containerEl instanceof HTMLElement) {
			Sortable.create(containerEl, {
				group: 'ingredients', // Shared group name enables cross-section dragging
				animation: 200,
				dataIdAttr: 'data-id',
				onEnd: function (evt) {
					const movedIngredientId = evt.item.getAttribute('data-id');
					const newSectionId = evt.to.getAttribute('data-section-id');
					
					try {
						// Find the ingredient that was moved
						const movedIng = $ingredients.find(i => i.ingredient_id == movedIngredientId);
						
						if (movedIng) {
							// Update section_id if moved to a different section
							const targetSectionId = newSectionId !== 'null' ? parseInt(newSectionId) : null;
							recipeStore.updateIngredient(movedIng.ingredient_id, {
								section_id: targetSectionId
							});
						}
					} catch (error) {
						showError(error.message);
					}
				}
			});
		}
	});

	// Get ingredients for this section
	$effect(() => {
		// Re-render when section or ingredients change
		void section;
		void $ingredients;
	});
</script>

<List>
	<div bind:this={containerEl} data-section-id={section.id} class="ingredient-container">
		{#each section.ingredients as ing, index}
			<div data-id={ing.ingredient_id} class="ingredient-item-wrapper">
				<IngredientItem
					{ing}
					{index}
					{ingSelected}
					ingredient_id={ing.ingredient_id}
					section_id={section.id}
					onEdit={(i) => (ingSelected = i)}
					onSave={() => (ingSelected = false)}
					onRemove={(id) => {
						try {
							recipeStore.deleteIngredient(id);
						} catch (error) {
							showError(error.message);
						}
					}}
					onChangeQuantity={(id, val) => {
						try {
							recipeStore.updateIngredient(id, { quantity: parseFloat(val) });
						} catch (error) {
							showError(error.message);
						}
					}}
					onChangeUnit={(id, val) => {
						try {
							recipeStore.updateIngredient(id, { unit_id: parseInt(val) });
						} catch (error) {
							showError(error.message);
						}
					}}
				/>
			</div>
		{/each}
	</div>
</List>

<style>
	.ingredient-container {
		min-height: 50px;
		padding: 0.5rem;
	}
	.ingredient-item-wrapper {
		cursor: move;
	}
</style>
