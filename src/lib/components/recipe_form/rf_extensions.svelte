<script>
	import { getContext, hasContext } from "svelte";
	import LayoutGrid, { InnerGrid, Cell } from "@smui/layout-grid";
	import Select, {Option} from "@smui/select";
	import Button, {Icon, Label} from "@smui/button";
	import Textfield from "@smui/textfield";
	import ChipInput from "@smui-extra/chip-input";
	import { mdiPlus, mdiDelete } from "@mdi/js";
	import { Separator } from "@smui/list";
	import DataTable, { Body, Cell as TCell, Head, Row } from "@smui/data-table";

	let {
		recipe_id,
		ingredient_list,
		extensions=$bindable([]),
		alternates=$bindable([])
	}= $props();
	let diets = $state([]);
	let diets_value = $state([]);
	let original_ingredient = $state('');
	let alternate_ingredient = $state('');
	let alternate_unit = $state('');
	let alternate_quantity = $state('');
	let extension_ingredients=$derived(alternates);

	/* Context */
	let allIngredients = getContext("all_ingredients");
	let units = getContext("units");
	let dietExtensions = (hasContext("extensions"))? getContext("extensions") : [];

	const addReplacement=()=>{
		extension_ingredients.push({
			recipe_id: recipe_id, 
			original_ingredient: original_ingredient,
			alternate_ingredient: alternate_ingredient,
			quantity: alternate_quantity,
			unit_id: alternate_unit,
			extensions: diets.map(d => d.id).join(",")
		});
	}


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
					bind:value={original_ingredient}
					>
					
					<Option />
					{#each ingredient_list as ing}
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
							bind:value={alternate_ingredient}
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
							bind:value={alternate_quantity}
							label="Quantity"
							type="number"
							min="0"
						/>
					</Cell>
					<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 2 }}>
						<Select
							key={(unit) => `${unit ? unit.name : ""}`}
							bind:value={alternate_unit}
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
		{#if extension_ingredients.length > 0}
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
					{#each extension_ingredients as alternate, i}
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
								<Button onclick={() => extension_ingredients.splice(i, 1)}>
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