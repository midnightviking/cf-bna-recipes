<script>
	import Button from '@smui/button';

	let { selectedRecipeIds = [], allRecipes = [], onSort } = $props();

	function sortRecipes(direction = 'asc') {
		const sorted = selectedRecipeIds
			.map((id) => allRecipes.find((r) => r?.id === id))
			.filter(Boolean)
			.sort((a, b) => {
				const aTitle = (a.title || '').toLowerCase();
				const bTitle = (b.title || '').toLowerCase();
				if (aTitle < bTitle) return direction === 'asc' ? -1 : 1;
				if (aTitle > bTitle) return direction === 'asc' ? 1 : -1;
				return 0;
			});

		const newIds = sorted.map((r) => r.id);
		onSort?.(newIds);
	}
</script>

<div class="recipe-sort-controls">
	<small>Sort recipes:</small>
	<Button size="small" variant="outlined" onclick={() => sortRecipes('asc')}
		>A → Z</Button
	>
	<Button size="small" variant="outlined" onclick={() => sortRecipes('desc')}
		>Z → A</Button
	>
</div>

<style lang="scss">
	.recipe-sort-controls {
		display: flex;
		align-items: center;
		gap: 0.5em;
		margin: 1em 0 0.5em 0;
		padding: 0.5em;
		background: #f9f9f9;
		border-radius: 4px;
	}
</style>
