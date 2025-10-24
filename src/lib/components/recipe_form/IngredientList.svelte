<script>
	import { onMount } from 'svelte';
	import Sortable from 'sortablejs';
	import List from "@smui/list";
	import IngredientItem from "./IngredientItem.svelte";
	
	let { section, ingredient_list = $bindable([]) } = $props();
	let ingSelected = $state(null);
	let containerEl;

	function removeIngredient(localIndex) {
		const index = ingredient_list.findIndex(i => i._localIndex === localIndex);
		if (index !== -1) {
			ingredient_list = ingredient_list.filter((_, i) => i !== index);
		}
	}

	onMount(() => {
		if (containerEl instanceof HTMLElement) {
			Sortable.create(containerEl, {
				group: 'ingredients', // Shared group name enables cross-section dragging
				animation: 200,
				dataIdAttr: 'data-id',
				onEnd: function (evt) {
					const movedItemId = evt.item.getAttribute('data-id');
					const newSectionId = evt.to.getAttribute('data-section-id');
					const newIndex = evt.newIndex;
					
					// Find the ingredient that was moved
					const movedIng = ingredient_list.find(i => i._localIndex == movedItemId);
					
					if (movedIng) {
						// Update section_id if moved to a different section
						if (newSectionId !== null) {
							movedIng.section_id = parseInt(newSectionId);
						}
						
						// Update ordering based on new position
						movedIng.ordering = newIndex;
						
						// Trigger reactivity
						ingredient_list = [...ingredient_list];
					}
				}
			});
		}
	});
</script>

<List>
	<div bind:this={containerEl} data-section-id={section.id} class="ingredient-container">
		{#each section.ingredients as ing, index}
			<div data-id={ing._localIndex} class="ingredient-item-wrapper">
				<IngredientItem
					{ing}
					{index}
					{ingSelected}
					_localIndex={ing._localIndex}
					section_id={section.id}
					onEdit={(i) => (ingSelected = i)}
					onSave={() => (ingSelected = false)}
					onRemove={() => removeIngredient(ing._localIndex)}
					onChangeQuantity={(i, val) => (ingredient_list[i].quantity = val)}
					onChangeUnit={(i, val) => (ingredient_list[i].unit_id = val)}
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
