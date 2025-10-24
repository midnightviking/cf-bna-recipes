<script>
	import { getContext } from "svelte";
	import { recipeStore } from "$lib/stores/recipeStore.js";
	import { showError } from "$lib/services/toast.js";
	import IngredientSelect from "./ingredient_select.svelte";
	import Textfield from "@smui/textfield";
	import Select, { Option } from "@smui/select";
	import Button, { Icon } from "@smui/button";
	import { mdiPlus } from "@mdi/js";
	import { InnerGrid, Cell } from "@smui/layout-grid";

	const units = getContext("units");
	
	// Destructure store
	const { sectionsByIngredient } = recipeStore;

	// Form state
	let new_ingredient = $state(null);
	let new_quantity = $state(null);
	let new_unit = $state(null);
	let new_ingredient_section = $state(-1); // Default section

	function addIngredientToRecipe() {
		// Validation
		if (
			!new_ingredient ||
			new_unit === null ||
			new_quantity <= 0 ||
			new_quantity === null
		) {
			showError("Please fill in all ingredient fields");
			return;
		}

		try {
			recipeStore.addIngredient({
				ingredient_id: new_ingredient.id,
				quantity: parseFloat(new_quantity),
				unit_id: parseInt(new_unit),
				section_id: new_ingredient_section > 0 ? new_ingredient_section : null,
			});

			// Reset form
			new_ingredient = null;
			new_unit = null;
			new_quantity = null;
			new_ingredient_section = -1;
		} catch (error) {
			showError(error.message);
		}
	}
</script>

<div class="add-ingredient-row">
	<InnerGrid>
		<Cell
			spanDevices={{
				desktop: 4,
				tablet: 8,
				phone: 4,
			}}
		>
			<IngredientSelect bind:value={new_ingredient} />
		</Cell>
		<Cell
			spanDevices={{
				desktop: 2,
				tablet: 4,
				phone: 2,
			}}
		>
			<Textfield
				bind:value={new_quantity}
				label="Quantity"
				type="number"
				min="0"
				step="0.01"
				input$step="0.01"
			/>
		</Cell>
		<Cell
			spanDevices={{
				desktop: 4,
				tablet: 4,
				phone: 2,
			}}
		>
			<Select
				key={(unit) => `${unit ? unit.name : ""}`}
				bind:value={new_unit}
				label="Unit"
			>
				{#each units as u}
					<Option value={u.id}>{u.name}</Option>
				{/each}
			</Select>
		</Cell>
		<Cell spanDevices={{ desktop: 8 }}>
			<Select
				value={new_ingredient_section}
				onchange={(e) => (new_ingredient_section = parseInt(e.detail.value))}
				key={(s) => `${s ? s.name : ""}`}
				label="Section"
			>
				<Option value={-1}>None</Option>
				{#each $sectionsByIngredient as section}
					<Option value={section.id}>
						{section.name}
					</Option>
				{/each}
			</Select>
		</Cell>
		<Cell
			span={4}
			spanDevices={{
				desktop: 2,
				tablet: 12,
				phone: 4,
			}}
			align="middle"
			style="align-content:end;"
		>
			<div class="end-button">
				<Button onclick={addIngredientToRecipe} variant="raised">
					<Icon tag="svg" viewBox="0 0 24 24">
						<path fill="currentColor" d={mdiPlus} />
					</Icon>
					Add
				</Button>
			</div>
		</Cell>
	</InnerGrid>
</div>

<style>
	.add-ingredient-row {
		margin: 1rem 0;
	}

	.end-button {
		display: flex;
		justify-content: flex-end;
	}
</style>
