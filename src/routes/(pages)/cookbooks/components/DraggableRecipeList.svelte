<script>
	import { onMount } from 'svelte';
	import Sortable from 'sortablejs';
	import { fade } from 'svelte/transition';

	let { selectedRecipeIds = $bindable([]), allRecipes = [], onReorder } = $props();

	let containerEl;
	let sortableInstance;
	
	// Local state for display order
	let localOrder = $derived([...selectedRecipeIds]);

	// Get ordered recipe objects from local IDs
	const orderedRecipes = $derived(
		localOrder
			?.map((id) => allRecipes?.find((r) => parseInt(r?.id) === parseInt(id)))
			.filter(Boolean)
	);
	
	$effect(()=>{
		selectedRecipeIds;
	});

	function handleRemoveRecipe(recipeId) {
		
		localOrder = localOrder.filter((id) => id !== recipeId);
		onReorder?.(localOrder);
	}

	function handleKeyboardReorder(event, currentIndex) {
		const maxIndex = orderedRecipes.length - 1;
		let newIndex = currentIndex;

		if (event.key === 'ArrowUp' && currentIndex > 0) {
			newIndex = currentIndex - 1;
			event.preventDefault();
		} else if (event.key === 'ArrowDown' && currentIndex < maxIndex) {
			newIndex = currentIndex + 1;
			event.preventDefault();
		} else {
			return; // No reordering needed
		}

		// Reorder the local array
		localOrder = sortableInstance.toArray();
		onReorder?.(localOrder);
	}

	onMount(() => {
		if (!containerEl) return;

		sortableInstance = Sortable.create(containerEl, {
			animation: 200,
			handle: '.drag-handle',
			ghostClass: 'sortable-ghost',
			chosenClass: 'sortable-chosen',
			dragClass: 'sortable-drag',
			dataIdAttr: 'data-recipe-id',

			onEnd:(evt)=> {
				selectedRecipeIds = sortableInstance.toArray();
			},
		});

		return () => {
			if (sortableInstance) {
				sortableInstance.destroy();
				sortableInstance = null;
			}
		};
	});
	</script>

<div class="draggable-recipe-list" bind:this={containerEl}>
	{#each orderedRecipes as recipe, idx (recipe.id)}
		<div 
			class="draggable-recipe" 
			data-recipe-id={recipe.id}
			in:fade={{ duration: 200 }}
			out:fade={{ duration: 200 }}
		>
			<div class="recipe-checkbox">
				<input
					type="checkbox"
					checked={true}
					aria-label={`Remove recipe ${recipe.title}`}
					onclick={(e) => {
						e.stopPropagation();
						handleRemoveRecipe(recipe.id);
					}}
				/>
			</div>

			<div class="recipe-title">{recipe.title}</div>

			<button
				class="drag-handle"
				type="button"
				tabindex="0"
				title="Drag to reorder (or use arrow keys)"
				aria-label={`Reorder ${recipe.title}`}
				onkeydown={(e) => handleKeyboardReorder(e, idx)}
			>
				<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true">
					<path
						fill="currentColor"
						d="M9 3H7v2h2V3m0 4H7v2h2V7m0 4H7v2h2v-2m0 4H7v2h2v-2m8-8h-2v2h2V7m0-4h-2v2h2V3m0 8h-2v2h2v-2m0 4h-2v2h2v-2Z"
					/>
				</svg>
			</button>
		</div>
	{/each}
</div>

<style lang="scss">
	.draggable-recipe-list {
		display: flex;
		flex-direction: column;
		gap: 0.3em;
	}

	.draggable-recipe {
		display: grid;
		grid-template-columns: auto 1fr minmax(auto, 0.5fr);
		align-items: center;
		gap: 0.5em;
		padding: 0.5em;
		border: 1px dashed #bbb;
		border-radius: 4px;
		background: #f5f5f5;
		cursor: default;
		transition: all 150ms ease-out;

		&:hover {
			background: #efefef;
			border-color: #999;
		}
	}

	/* SortableJS classes */
	:global(.sortable-ghost) {
		opacity: 0.4;
		background: #e3f2fd;
	}

	:global(.sortable-chosen) {
		background: #f0f0f0;
		border-color: #2196f3;
	}

	:global(.sortable-drag) {
		opacity: 1;
		background: #e3f2fd;
		box-shadow: 0 4px 12px rgba(33, 150, 243, 0.4);
		border-color: #2196f3;
	}

	.recipe-checkbox {
		display: flex;
		align-items: center;

		input[type='checkbox'] {
			cursor: pointer;
		}
	}

	.recipe-title {
		font-weight: 600;
		word-break: break-word;
		padding: 0 0.5em;
	}

	.drag-handle {
		background: rgb(145 145 145 / 22%);
		border: none;
		cursor: grab;
		padding: 0.4em 0.3em;
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 3px;
		color: #555;
		transition: all 150ms ease-out;
		width: 64px;
		justify-self: end;

		&:hover {
			background: rgb(145 145 145 / 35%);
			color: #000;
		}

		&:active {
			cursor: grabbing;
			background: rgb(145 145 145 / 45%);
		}

		&:focus {
			outline: 2px solid #2196f3;
			outline-offset: 2px;
		}
	}
</style>
