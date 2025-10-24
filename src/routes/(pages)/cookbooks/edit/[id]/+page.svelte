<script>
	import CookbookForm from '../../CookbookForm.svelte';
	import { setContext } from 'svelte';

	let { data } = $props();
	let { cookbook, recipes, error } = data;

	setContext('all_recipes', recipes || []);
</script>

<div class="cookbook-edit-page">
	<h2>Edit Cookbook</h2>

	{#if error}
		<div class="error-container">
			<h3>Failed to Load Cookbook</h3>
			<p>{error}</p>
			<a href="/cookbooks" class="back-link">← Back to Cookbooks</a>
		</div>
	{:else if !cookbook}
		<div class="loading-container">
			<p>Loading cookbook...</p>
		</div>
	{:else if !recipes || recipes.length === 0}
		<div class="warning-container">
			<h3>No Recipes Available</h3>
			<p>There are no recipes to add to this cookbook. Please create some recipes first.</p>
			<a href="/recipes/add" class="action-link">Create a Recipe</a>
		</div>
	{:else}
		<div class="form-wrapper">
			<div class="cookbook-header">
				<h3>{cookbook.name}</h3>
				<p class="recipe-count">{cookbook.recipes?.length || 0} recipes</p>
			</div>
			<CookbookForm {...cookbook} />
		</div>
	{/if}
</div>

<style lang="scss">
	.cookbook-edit-page {
		padding: 2em;
		// max-width: 900px;
		margin: 0 auto;

		h2 {
			color: #333;
			margin-bottom: 1.5em;
		}
	}

	.cookbook-header {
		margin-bottom: 1.5em;
		padding: 1em;
		background: #f5f5f5;
		border-radius: 6px;
		display: flex;
		justify-content: space-between;
		align-items: center;

		h3 {
			margin: 0;
			color: #333;
		}

		.recipe-count {
			margin: 0;
			color: #999;
			font-size: 0.95em;
		}
	}

	.form-wrapper {
		background: white;
		border-radius: 6px;
		border: 1px solid #e0e0e0;
		overflow: hidden;
	}

	.error-container,
	.warning-container,
	.loading-container {
		padding: 2em;
		text-align: center;
		border-radius: 6px;
		background: #f5f5f5;

		h3 {
			margin: 0 0 0.5em 0;
			color: #333;
		}

		p {
			color: #666;
			margin: 0.5em 0;
		}
	}

	.error-container {
		background: #ffebee;
		border: 1px solid #ffcdd2;

		h3 {
			color: #c62828;
		}

		p {
			color: #b71c1c;
		}
	}

	.warning-container {
		background: #fff3e0;
		border: 1px solid #ffe0b2;

		h3 {
			color: #e65100;
		}

		p {
			color: #d84315;
		}
	}

	.back-link,
	.action-link {
		display: inline-block;
		margin-top: 1em;
		padding: 0.75em 1.5em;
		background: #2196f3;
		color: white;
		text-decoration: none;
		border-radius: 4px;
		transition: background 150ms ease-out;

		&:hover {
			background: #1976d2;
		}
	}

	.action-link {
		background: #4caf50;

		&:hover {
			background: #388e3c;
		}
	}
</style>