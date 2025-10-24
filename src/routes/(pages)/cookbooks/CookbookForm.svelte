<script>
	import { goto } from '$app/navigation';
	import { useBannerActions } from '$lib/action-banner-state.svelte';
	import Button from '@smui/button';
	import Textfield from '@smui/textfield';
	import { getContext } from 'svelte';
	import RecipeSelector from './components/RecipeSelector.svelte';
	import { validateCookbookName, validateCookbookDescription } from '$lib/utils/cookbook-validation.js';
	import { saveCookbook, formatCookbookForApi } from '$lib/utils/api-helpers.js';

	let { id = null, name = '', description = '', recipes = [] } = $props();

	const editing = id ? true : false;
	const all_recipes = getContext('all_recipes');

	let selectedRecipeIds = $state((recipes || []).filter(Boolean).map((r) => r.id));
	let isLoading = $state(false);
	let errors = $state({});
	let successMessage = $state('');

	function validateForm() {
		errors = {};

		const nameValidation = validateCookbookName(name);
		if (!nameValidation.isValid) {
			errors.name = nameValidation.error;
		}

		const descValidation = validateCookbookDescription(description);
		if (!descValidation.isValid) {
			errors.description = descValidation.error;
		}

		return Object.keys(errors).length === 0;
	}

	async function handleSave() {
		if (!validateForm()) return;

		isLoading = true;
		successMessage = '';

		try {
			const cookbook = formatCookbookForApi(
				{
					name,
					description,
					selectedRecipeIds,
				},
				editing ? id : null
			);

			const result = await saveCookbook(cookbook, editing);

			if (!result.success) {
				errors.api = result.error;
				isLoading = false;
				return;
			}

			successMessage = editing ? 'Cookbook updated successfully!' : 'Cookbook created successfully!';
			setTimeout(() => {
				goto('/cookbooks');
			}, 500);
		} catch (error) {
			errors.api = error.message || 'Failed to save cookbook';
			isLoading = false;
		}
	}

	function handleCancel() {
		if (confirm('Discard unsaved changes?')) {
			history.back();
		}
	}

	function handleRecipesChange(newIds) {
		selectedRecipeIds = newIds;
		if (errors.recipes) {
			delete errors.recipes;
		}
	}

	const banner_actions = [
		{ label: editing ? 'Update' : 'Save', icon: '', func: handleSave },
		{ label: 'Cancel', icon: '', func: handleCancel },
	];

	useBannerActions(banner_actions);
</script>

<div class="cookbook-form-container">
	{#if successMessage}
		<div class="success-message">
			{successMessage}
		</div>
	{/if}

	{#if errors.api}
		<div class="error-message">
			<strong>Error:</strong> {errors.api}
		</div>
	{/if}

	<div class="form-section">
		<h3>Cookbook Details</h3>

		<div class="form-group">
			<Textfield
				bind:value={name}
				label="Cookbook Name *"
				required
				class="cookbook-name-field"
				style="width: 100%;"
				input$style="width: 100%"
				input$maxlength="100"
				invalid={!!errors.name}
			/>
			{#if errors.name}
				<div class="field-error">{errors.name}</div>
			{/if}
		</div>

		<div class="form-group">
			<Textfield
				bind:value={description}
				label="Description"
				class="cookbook-description-field"
				style="width: 100%;"
				input$style="width: 100%; min-height: 80px; vertical-align: top;"
				input$maxlength="500"
				invalid={!!errors.description}
			/>
			{#if errors.description}
				<div class="field-error">{errors.description}</div>
			{/if}
		</div>
	</div>

	<div class="form-section">
		<RecipeSelector
			bind:selectedRecipeIds
			allRecipes={all_recipes}
			onRecipesChange={handleRecipesChange}
		/>
		{#if errors.recipes}
			<div class="error-message" style="margin-top: 1em;">
				{errors.recipes}
			</div>
		{/if}
	</div>

	<div class="form-actions">
		<Button
			onclick={handleSave}
			disabled={isLoading}
			class="save-button"
		>
			{isLoading ? 'Saving...' : editing ? 'Update' : 'Save'}
		</Button>
		<Button onclick={handleCancel} color="secondary">
			Cancel
		</Button>
	</div>
</div>

<style lang="scss">
	.cookbook-form-container {
		display: flex;
		flex-direction: column;
		gap: 1.5em;
		padding: 1em;
		max-width: 1280px;
		margin: 0 auto;
	}

	.form-section {
		display: flex;
		flex-direction: column;
		gap: 1em;

		h3 {
			margin: 0;
			color: #333;
			font-size: 1.1em;
		}
	}

	.form-group {
		display: flex;
		flex-direction: column;
		gap: 0.5em;
	}

	.field-error {
		color: #d32f2f;
		font-size: 0.85em;
		margin-top: -0.3em;
	}

	.error-message {
		padding: 0.75em 1em;
		background: #ffebee;
		border-left: 4px solid #d32f2f;
		color: #c62828;
		border-radius: 2px;
		font-size: 0.95em;
	}

	.success-message {
		padding: 0.75em 1em;
		background: #e8f5e9;
		border-left: 4px solid #4caf50;
		color: #2e7d32;
		border-radius: 2px;
		font-size: 0.95em;
	}

	.form-actions {
		display: flex;
		gap: 1em;
		margin-top: 1em;
		padding-top: 1em;
		border-top: 1px solid #eee;
	}
</style>