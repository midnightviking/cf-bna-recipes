<Textfield
	bind:value={name}
	label="Cookbook Name"
	required
	class="cookbook-name-field"
	style="width:100%;"
	input$style="width:100%"
/>
<br>
<Textfield
	bind:value={description}
	label="Description"
	class="cookbook-description-field"
	style="width:100%;"
	input$style="width:100%"
/>
<br>

<label class="cookbook-recipe-label" for="cookbook-recipe-select">Select & Order Recipes:</label>
<div class="cookbook-sort">
	<small>Quick Sort:</small>
	<Button size="small" onclick={() => sortSelectedRecipes('asc')}>A → Z</Button>
	<Button size="small" onclick={() => sortSelectedRecipes('desc')}>Z → A</Button>
</div>
<div id="cookbook-recipe-select" class="cookbook-recipe-select">
	{#each getCookbookRecipesByOrder() as recipe, idx}
		<div class="draggable-recipe {idx===dragIndex ? 'dragging' : ''}" data-index={idx}>
			<input
				type="checkbox"
				value={recipe.id}
				bind:group={selectedRecipeIds}
				aria-label={`Select recipe ${recipe.title}`}
			/>
			<span class="title">{recipe.title}</span>
			<button
				class="drag-handle"
				type="button"
				draggable="true"
				title="Drag to reorder"
				aria-label={`Reorder ${recipe.title}`}
				ondragstart={(e)=>startDrag(e, idx)}
				ondragover={(e)=>dragOver(e, idx)}
				ondrop={finishDrag}
				ondragend={cancelDrag}
				onkeydown={(e)=>handleKeyReorder(e, idx)}
			>
				<svg viewBox="0 0 24 24" width="18" height="18" aria-hidden="true"><path fill="currentColor" d="M9 3H7v2h2V3m0 4H7v2h2V7m0 4H7v2h2v-2m0 4H7v2h2v-2m8-8h-2v2h2V7m0-4h-2v2h2V3m0 8h-2v2h2v-2m0 4h-2v2h2v-2Z" /></svg>
			</button>
		</div>
	{/each}
	<!-- Add unchecked recipes -->
	{#each all_recipes.filter((r) => !selectedRecipeIds.includes(r.id)) as recipe}
		<label
			><input
				type="checkbox"
				value={recipe.id}
				bind:group={selectedRecipeIds}
			/>
			{recipe.title}</label>
	{/each}
</div>



<div class="form-actions">
	<Button onclick={saveCookbook}>{editing ? "Update" : "Save"}</Button>
	<Button onclick={()=>{goto(history.back())}} color="secondary">Cancel</Button>
</div>

<script>
	import { goto } from "$app/navigation";
	import { useBannerActions } from "$lib/action-banner-state.svelte";
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";
	import { getContext } from "svelte";
	
	let {
		id=null, 
		name = "", 
		description = "", 
		recipes = [], 

	}= $props();
	const editing = id ? true: false;
	let selectedRecipeIds = $state([]);
	selectedRecipeIds = (recipes || []).map((r) => {
		if(r?.id){
			return r.id;
		}
	});

	let all_recipes = getContext("all_recipes");

	function getCookbookRecipesByOrder() {
		return selectedRecipeIds
			.map((id) => all_recipes.find((r) => r?.id === id))
			.filter(Boolean);
	}
	
	function handleDragStart(e, idx) {
		// legacy - replaced by startDrag
	}

	let dragIndex = $state(null);
	let lastHoverIndex = null;

	function startDrag(event, idx){
		dragIndex = idx;
		lastHoverIndex = idx;
		try { event.dataTransfer.setData('text/plain', String(idx)); } catch {}
		if(event.dataTransfer){
			event.dataTransfer.effectAllowed = 'move';
		}
	}

	function dragOver(event, idx){
		if(dragIndex === null) return;
		event.preventDefault(); // allow drop
		if(idx === lastHoverIndex) return;
		reorderSelected(dragIndex, idx);
		lastHoverIndex = idx;
		dragIndex = idx;
	}

	function finishDrag(event){
		event.preventDefault();
		dragIndex = null;
		lastHoverIndex = null;
	}

	function cancelDrag(){
		dragIndex = null;
		lastHoverIndex = null;
	}

	function reorderSelected(from, to){
		if(from === to || from == null || to == null) return;
		const order = [...selectedRecipeIds];
		const [moved] = order.splice(from,1);
		order.splice(to,0,moved);
		selectedRecipeIds = order;
	}

	function handleKeyReorder(event, idx){
		if(event.key === 'ArrowUp' && idx > 0){
			reorderSelected(idx, idx-1);
			event.preventDefault();
		}else if(event.key === 'ArrowDown' && idx < getCookbookRecipesByOrder().length -1){
			reorderSelected(idx, idx+1);
			event.preventDefault();
		}
	}

	function sortSelectedRecipes(dir = 'asc') {
		// Map ids to recipe objects (filter out any missing) then sort by title
		const sorted = selectedRecipeIds
			.map(id => all_recipes.find(r => r?.id === id))
			.filter(Boolean)
			.sort((a, b) => {
				const at = (a.title || '').toLowerCase();
				const bt = (b.title || '').toLowerCase();
				if (at < bt) return dir === 'asc' ? -1 : 1;
				if (at > bt) return dir === 'asc' ? 1 : -1;
				return 0;
			});
		selectedRecipeIds = sorted.map(r => r.id);
	}

	async function saveCookbook() {
		const cookbook = {
			id: editing ? id : undefined,
			name,
			description,
			// recipeIds removed, handled by join table
			recipes: selectedRecipeIds.map((id, idx) => ({
				id,
				ordering: idx,
			})),
		};
		if (editing) {
			await fetch("/api/cookbooks", {
				method: "PUT",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({ ...cookbook, id: id }),
			}).then(
				goto('/cookbooks')
			);
		} else {
			await fetch("/api/cookbooks", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(cookbook),
			}).then(
				goto('/cookbooks')
			);
		}
	}

	
	const banner_actions = [
			{label:editing?"Update":"Save", icon: "", func: saveCookbook},
			{label:"Cancel", icon: "", func: ()=>{history.back()}}
		];

	useBannerActions(banner_actions);

</script>

<style lang="scss">
	
	.cookbook-sort {
		margin: 0.5em 0;
		display: flex;
		align-items: center;
		gap: 0.5em;
	}
	.cookbook-recipe-list {
		margin-top: 0.5em;
		padding-left: 1.2em;
	}
	.cookbook-recipe-item {
		margin-bottom: 0.2em;
	}
	.cookbook-recipe-label {
		margin-top: 1em;
		font-weight: bold;
	}
	.cookbook-recipe-select {
		margin-bottom: 1em;
		display:flex;
		flex-direction: column;
	}
	.draggable-recipe {
		display: grid;
		grid-template-columns: auto 1fr minmax(auto, 0.5fr);
		align-items: center;
		gap: 0.5em;
		padding: 0.3em 0.5em;
		border: 1px dashed #bbb;
		border-radius: 4px;
		margin-bottom: 0.3em;
		background: #f5f5f5;
		cursor: default;
	}
	.draggable-recipe:active {
		background: #e0e0e0;
	}
	.draggable-recipe.dragging {
		outline: 2px solid #888;
		background: #eef;
	}
	.draggable-recipe .title {
		font-weight: 600;
	}
	.drag-handle {
		background: rgb(145 145 145 / 22%);
		border: none;
		cursor: grab;
		padding: 0.2em 0.5em;
		display: flex;
		justify-content: flex-end;


		color: #555;
	}
	.drag-handle:active {
		cursor: grabbing;
	}
	.drag-handle:hover {
		color: #000;
	}
	.form-actions {
		margin-top: 1rem;
		display: flex;
		gap: 1rem;
	}
</style>