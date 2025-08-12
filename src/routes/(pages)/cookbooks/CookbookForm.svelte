<Textfield
	bind:value={name}
	label="Cookbook Name"
	required
	class="cookbook-name-field"
/>
<br>
<Textfield
	bind:value={description}
	label="Description"
	class="cookbook-description-field"
/>
<br>

<label class="cookbook-recipe-label" for="cookbook-recipe-select">Select & Order Recipes:</label>
<div id="cookbook-recipe-select" class="cookbook-recipe-select">
	{#each getCookbookRecipesByOrder() as recipe, idx}
		<div
			class="draggable-recipe"
			draggable="true"
			role="listitem"
			
		>
			<input
				type="checkbox"
				value={recipe.id}
				bind:group={selectedRecipeIds}
			/>
			{recipe.title}
			<span class="cookbook-recipe-category"
				>({recipe.category})</span
			>
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
			{recipe.title}</label
		>
	{/each}
</div>



<div class="form-actions">
	<Button onclick={saveCookbook}>{editing ? "Update" : "Save"}</Button>
	<Button onclick={()=>{goto(history.back())}} color="secondary">Cancel</Button>
</div>

<script>
	import { goto } from "$app/navigation";
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
		dragIndex = idx;
		e.dataTransfer.effectAllowed = "move";
	}

	function handleDragOver(e, idx) {
		e.preventDefault();
		if (dragIndex === null || dragIndex === idx) return;
		const newOrder = [...selectedRecipeIds];
		const [moved] = newOrder.splice(dragIndex, 1);
		newOrder.splice(idx, 0, moved);
		selectedRecipeIds = newOrder;
		dragIndex = idx;
	}

	function handleDrop(e) {
		e.preventDefault();
		dragIndex = null;
	}

	function handleDragEnd() {
		dragIndex = null;
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
		> label{
		}
	}
	.draggable-recipe {
		display: flex;
		align-items: center;
		gap: 0.5em;
		padding: 0.3em 0.5em;
		border: 1px dashed #bbb;
		border-radius: 4px;
		margin-bottom: 0.3em;
		background: #f5f5f5;
		cursor: grab;
	}
	.draggable-recipe:active {
		background: #e0e0e0;
	}
	.form-actions {
		margin-top: 1rem;
		display: flex;
		gap: 1rem;
	}
</style>