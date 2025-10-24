<script>
	import { getContext, hasContext } from "svelte";
	import { recipeStore } from "$lib/stores/recipeStore.js";
	import { showError } from "$lib/services/toast.js";
	import LayoutGrid, { InnerGrid, Cell } from "@smui/layout-grid";
	import Select, {Option} from "@smui/select";
	import Button, {Icon, Label} from "@smui/button";
	import Textfield from "@smui/textfield";
	import ChipInput from "@smui-extra/chip-input";
	import { mdiPlus, mdiDelete } from "@mdi/js";
	import { Separator } from "@smui/list";
	import DataTable, { Body, Cell as TCell, Head, Row } from "@smui/data-table";

	// Destructure stores
	const { ingredients, alternates } = recipeStore;
	
	let diets = $state([]);
	let diets_value = $state([]);
	let original_ingredient = $state('');
	let alternate_ingredient = $state('');
	let alternate_unit = $state('');
	let alternate_quantity = $state('');

	/* Context */
	let allIngredients = getContext("all_ingredients");
	let units = getContext("units");
	let dietExtensions = (hasContext("extensions"))? getContext("extensions") : [];

	const addReplacement = () => {
		try {
			if (!original_ingredient || !alternate_ingredient) {
				showError("Please select both original and alternate ingredients");
				return;
			}
			
			recipeStore.addAlternate({
				original_ingredient: original_ingredient,
				alternate_ingredient: alternate_ingredient,
				quantity: alternate_quantity ? parseFloat(alternate_quantity) : 0,
				unit_id: alternate_unit ? parseInt(alternate_unit) : null,
				extensions: diets.map(d => d.id).join(",")
			});
			
			// Reset form
			original_ingredient = '';
			alternate_ingredient = '';
			alternate_quantity = '';
			alternate_unit = '';
			diets = [];
			diets_value = [];
		} catch (error) {
			showError(error.message);
		}
	};

	function display_ingredient_name(id){
		const ingredient = allIngredients.find(ing => ing.id === id);
		return ingredient ? ingredient.name : '';
	}

	function display_units_name(id){
		const unit = units.find(u => u.id === id);
		return unit ? unit.name : '';
	}

	function extension_names(id){
		if (!id) return '';
		let ids = Array.isArray(id) ? id : typeof id === 'string' ? id.split(',') : [String(id)];		
		return dietExtensions
			.filter(ext => ids.includes((ext.id)))
			.map(ext => ext.name)
			.join(', ');
	}
</script>

<InnerGrid>
	<Cell span={12}>
		
<strong>Dietary Extenstions:</strong>
<div class="">
	
	<div class="">
		
				<Select
					key={(ing) => `${ing ? ing.ingredient_id : ""}`}
					label="Select Ingredient to Replace"
					value={original_ingredient}
					onchange={(e) => (original_ingredient = e.detail.value)}
					>
					
					<Option />
					{#each $ingredients as ing}
						<Option value={ing.ingredient_id}>{ing.name}</Option>
					{/each}
				</Select>
				<span>
					replaced with
				</span>
			<div class="ingredient-replacement recipe-ingredients">
				<InnerGrid>
					<Cell  spanDevices={{ desktop: 4, tablet: 8, phone: 4 }}>
						<Select
							key={(ing) => `${ing ? ing.name : ""}`}
							value={alternate_ingredient}
							onchange={(e) => (alternate_ingredient = e.detail.value)}
							label="Select Ingredient"
							>
							<Option/>
							{#each allIngredients as ing}
							<Option value={ing.id}>{ing.name}</Option>
							{/each}
						</Select>
					</Cell>
					<Cell  spanDevices={{ desktop: 2, tablet: 4, phone: 2}}>
						<Textfield
							value={alternate_quantity}
							oninput={(e) => (alternate_quantity = e.target.value)}
							label="Quantity"
							type="number"
							min="0"
						/>
					</Cell>
					<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 2 }}>
						<Select
							key={(unit) => `${unit ? unit.name : ""}`}
							value={alternate_unit}
							onchange={(e) => (alternate_unit = e.detail.value)}
							label="Unit"
						>
							<!-- <Option value="">Select unit</Option> -->
							{#each units as u}
								<Option value={u.id}>{u.name}</Option>
							{/each}
						</Select>
					</Cell>
					
				</InnerGrid>
			</div>
			<div class="restriction-input">

				<ChipInput
				bind:value={diets_value}
				bind:chips={diets}
				getChipLabel={(d)=>`${d.name}`}
				getChipText={(d)=>d.name}
				key={(_diet)=>`${_diet ? _diet.name: ""}`}
				
				chipTrailingAction$aria-label="Remove Extension"
				
				autocomplete$options={
					dietExtensions.filter(
						(diet)=>!diets.find((d)=>d.name===diet.name)
					)
				}
				autocomplete$showMenuWithNoInput
				autocomplete$getOptionLabel={(d)=>`${d.name}`}
				>
				{#snippet chipTrailingAction()}
				<svg style="display: block;" viewBox="0 0 24 24">
					<path fill="currentColor" d={mdiDelete} />
				</svg>
				{/snippet}
				{#snippet label()}
				Which diet to include?
				{/snippet}
			</ChipInput>
		</div>
		
			<Button onclick={addReplacement}>
				Add Replacement
			</Button>
		
	</div>
	<Separator/>

	<div class="current_extensions">
		{#if $alternates.length > 0}
			<DataTable>
				<Head>
					<Row>
						<TCell>Ingredient</TCell>
						<TCell>Quantity</TCell>
						<TCell>Unit</TCell>
						<TCell>Extensions</TCell>
						<TCell>&nbsp;</TCell>
					</Row>
				</Head>
				<Body>
					{#each $alternates as alternate}
						<Row>
							<TCell>
								<small>
									{display_ingredient_name(alternate.original_ingredient)}
								</small>
								<br>
								<strong>
									{display_ingredient_name(alternate.alternate_ingredient)}
								</strong>
							</TCell>
							<TCell>
								{alternate.quantity}
							</TCell>
							<TCell>
								{display_units_name(alternate.unit_id)}
							</TCell>
							<TCell>
								{extension_names(alternate.extensions)}
							</TCell>
							<TCell>
								<Button onclick={() => {
									try {
										recipeStore.deleteAlternate(alternate.id);
									} catch (error) {
										showError(error.message);
									}
								}}>
									<Icon>
										<svg style="display: block;" viewBox="0 0 24 24">
											<path fill="currentColor" d={mdiDelete} />
										</svg>
									</Icon>
								</Button>
							</TCell>
						</Row>
					{/each}
				</Body>
			</DataTable>
		{:else}
			<p class="no-extensions">No dietary replacements added yet.</p>
		{/if}
	</div>
</div>

	</Cell>
</InnerGrid>