<script>
	import { getContext } from "svelte";
	import IngredientSelect from "./ingredient_select.svelte";
	import Textfield from "@smui/textfield";
	import Select, { Option } from "@smui/select";
	import Button, { Icon } from "@smui/button";
	import { mdiPlus } from "@mdi/js";
	import { InnerGrid, Cell } from "@smui/layout-grid";

	let {
		section_list = $bindable([]),
		ingredient_list = $bindable([]),
		_localIndex = $bindable(0),
	} = $props();

	const units = getContext("units");

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
			return;
		}

		const unit = units.find((u) => u.id == new_unit);
		if (!unit) return;

		// Create new ingredient entry
		let newIng = {
			ingredient_id: new_ingredient.id,
			name: new_ingredient.name,
			quantity: new_quantity,
			unit_id: unit.id,
			unit_name: unit.name,
			section_id: new_ingredient_section,
			_localIndex: _localIndex++,
		};

		ingredient_list = [...ingredient_list, newIng];

		// Reset form
		new_ingredient = null;
		new_unit = null;
		new_quantity = null;
		new_ingredient_section = -1;
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
				bind:value={new_ingredient_section}
				key={(s) => `${s ? s.name : ""}`}
				label="Section"
			>
				{#each section_list as section}
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
