<script>
	import Button, { Icon } from "@smui/button";
	import Textfield from "@smui/textfield";
	import Select, { Option } from "@smui/select";
	import LayoutGrid, { InnerGrid, Cell } from "@smui/layout-grid";
	import List, {
		Item,
		Graphic,
		Separator,
		Text,
		Meta,
		SecondaryText,
		PrimaryText,
		Subheader,
	} from "@smui/list";
	import {
		mdiDelete,
		mdiPlus,
		mdiClose,
		mdiKeyboardReturn,
		mdiPencilPlus,
	} from "@mdi/js";
	import { goto, invalidate, invalidateAll } from "$app/navigation";
	import { getContext, onMount, onDestroy, setContext } from "svelte";
	import RfExtensions from "$lib/components/recipe_form/rf_extensions.svelte";
	import { useBannerActions } from "$lib/action-banner-state.svelte";
	import Autocomplete from "@smui-extra/autocomplete";
	import IngredientSelect from "$lib/components/recipe_form/ingredient_select.svelte";
	import IngredientItem from "$lib/components/recipe_form/IngredientItem.svelte";
	import Sortable from "sortablejs";

	const itemTypes = [
		"bread",
		"veggie",
		"soup",
		"entree",
		"dessert",
		"protein",
		"sauce/gravy",
		"starch",
	];
	const categories = [
		"breakfast",
		"veggies",
		"starches",
		"entrees",
		"dessert",
	];
	/* Init values*/
	let new_ingredient = $state(null);
	let new_quantity = $state(null);
	let new_unit = $state(null);
	let new_ingredient_section = $state(-1);
	let new_section_name = $state("");
	let ingSelected = $state(null);
	let allIngredients = getContext("all_ingredients");
	let units = getContext("units");
	console.clear();

	let {
		id = null,
		title = "",
		minTemp = "",
		itemType = "",
		portionSize = "",
		calories = "",
		protein = "",
		category = "",
		instructions = "",
		ccp = "",
		substitutions = "",
		initialServings = 100,
		ingredients = [],
		sections = [],
		selectedExtensions = [],
		alternates = [],
	} = $props();

	let _localIndex = 0;
	let ingredient_list = $state(
		(ingredients ?? []).map((i) => ({
			...i,
			section_id: i.section_id ?? -1,
			_localIndex: _localIndex++,
		}))
	);

	// let section_list = $state();
	let section_list = $derived.by(()=>{
		const s = [{
			ordering: -1,
			name: "Default",
			el: {},
			id: -1,
		}];

		sections.forEach((s) => {
			let section = {
				...s,
				ordering: s.ordering ?? 0,
				el: s.el ?? {},
			};
			s.push(section);
		});
		return s;
	});

	onMount(async () => {
		section_list.forEach((section, i) => {
			section.ingredients = ingredient_list.filter(
				(i) => i.section_id === section.id
			);
			
			Sortable.create(section.el, {
				group: {
					name: section?.name ?? "section-" + i,
					section_id: section.id,
					put: (t, f) => {
						return true;
					},
				},
				animation: 200,
				store: {
					set: function (sortable) {
						let sorder = sortable.toArray();
						let _sid =
							sortable.el.getAttribute("data-section-id") ?? -1;

						section.sorting_group = sorder;
						// console.log(sortable.el)
						section_list.ingredients = [];
						sorder.forEach((s, _i) => {
							let ing = ingredient_list.find(
								(i) => i._localIndex == s
							);
							if (!ing) {
								return;
							}
							ing.section_id = parseInt(_sid);
							ing.ordering = parseInt(_i);
							section_list.ingredients.push(ing);
						});
					},
				},
			});
		});
	});

	const addIngredientToRecipe = () => {
		if (
			!new_ingredient ||
			new_unit === null ||
			new_quantity <= 0 ||
			new_quantity === null
		)
			return;
		// const ing = allIngredients.find((i) => i.id == new_ingredient);
		const ing = new_ingredient;
		const unit = units.find((u) => u.id == new_unit);
		if (!ing || !unit) return;

		// Prevent duplicates
		// if (ingredients?.some((i) => i.ingredient_id == new_unit)) return;
		let newIng = {
			ingredient_id: ing.id,
			name: ing.name,
			quantity: new_quantity,
			unit_id: unit.id,
			unit_name: unit.name,
			section_id: new_ingredient_section,
			_localIndex: _localIndex++,
		};

		ingredient_list = [...ingredient_list, newIng] ?? [newIng];
		
		//reset
		new_ingredient = null;
		new_unit = null;
		new_quantity = null;
		new_ingredient_section = -1;
	};

	const removeIngredientFromRecipe = (index, section) => {
		console.log(index, section);
		if (section) {
			if (section_list[section].ingredients.length > 0) {
				console.log(section_list[section].ingredients);
			}
		} else if (ingredient_list.length > 0) {
			ingredient_list.splice(index, 1);
		}
	};

	async function saveRecipe() {
		const recipe = {
			id: id ? id : undefined,
			title,
			minTemp,
			itemType,
			portionSize,
			calories,
			protein,
			category,
			instructions,
			ccp,
			substitutions,
			initialServings,
			ingredients: ingredient_list.map((i, idx) => ({
				id: i.id, // include row id when editing to enable diff-based updates
				ingredient_id: i.ingredient_id,
				quantity: i.quantity,
				unit_id: i.unit_id,
				// maintain existing order when saving
				ordering: i.ordering ?? idx,
				section_id: parseInt(i.section_id) ?? -1,
			})),
			sections: section_list
				.filter((s) => s.id > -1)
				.map((s, idx) => ({
					id: s.id,
					name: s.name,
					ordering: s.ordering ?? idx,
				})),
			extensions: selectedExtensions,
			alternates: alternates.map((a) => ({ ...a })),
		};

		console.log(recipe);
		if (id) {
			await fetch("/api/recipes", {
				method: "PUT",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({ ...recipe, id: id }),
			}).then(async (res) => {
				//success, now do the next thing
				goto("/recipes");
			});
		} else {
			await fetch("/api/recipes", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(recipe),
			}).then(async (res) => {
				//success, now do the next thing
				// console.log('Success')
				goto("/recipes");
			});
		}
	}

	const banner_actions = [
		{ label: id ? "Update" : "Save", icon: "", func: saveRecipe },
		{
			label: "Cancel",
			icon: "",
			func: () => {
				goto(history.back());
			},
		},
	];

	useBannerActions(banner_actions);
</script>

<h3>
	{id ? "Edit " + title + "" : "Add"} Recipe
</h3>
<div id="recipe-dialog-content">
	<div class="recipe-form" style="width:100%;">
		<LayoutGrid>
			
			<Separator />
			<Cell span={12}>
				<strong>Ingredients</strong>
			</Cell>
			<!-- Sections Management -->
			<Cell span={12}>
				<div class="recipe-sections">
					<strong>Sections</strong>
					<div class="sections-list">
						{#each section_list as s, si}
							{#if s.id>0}
							<div class="section-row">
								<input
									type="text"
									bind:value={section_list[si].name}
									placeholder="Section name"
								/>
								<button
									type="button"
									title="Remove"
									onclick={() => {
										section_list.splice(si, 1);
										section_list = [...section_list];
									}}>Remove</button
								>
							</div>
							{/if}
						{/each}
					</div>
					<div class="add-section">
						<input
							type="text"
							bind:value={new_section_name}
							placeholder="New section name"
						/>
						<button
							type="button"
							onclick={() => {
								if ((new_section_name || "").trim()) {
									section_list = [
										...section_list,
										{
											name: new_section_name.trim(),
											ordering: section_list.length,
										},
									];
									new_section_name = "";
								}
							}}>Add Section</button
						>
					</div>
				</div>
			</Cell>
			<!-- Recipe Ingredients -->
			<Cell span={12}>
				<Textfield
					bind:value={initialServings}
					label="Servings the recipe is based on"
					type="number"
					class="recipe-initial-servings-field"
					default="100"
				/>
			</Cell>

			<Cell span={12}>
				<div class="recipe-ingredients-section">
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
									step="2"
									input$step="2"
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
									<Button
										onclick={addIngredientToRecipe}
										variant="raised"
									>
										<Icon tag="svg" viewBox="0 0 24 24"
											><path
												fill="currentColor"
												d={mdiPlus}
											/></Icon
										>
										Add
									</Button>
								</div>
							</Cell>
						</InnerGrid>
					</div>
					<div class="recipe-ingredient-list">
						{#each section_list as section, s}
							<h4>
								{section?.name}
							</h4>
							<List>
								<div
									bind:this={section.el}
									data-section-id={section.id}
								>
									{#each section.ingredients as ing, index}
										<IngredientItem
											{ing}
											{index}
											{ingSelected}
											_localIndex={ing._localIndex}
											section_id={section.id}
											onEdit={(i) => (ingSelected = i)}
											onSave={() => (ingSelected = false)}
											onRemove={(i) =>
												removeIngredientFromRecipe(
													i,
													s
												)}
											onChangeQuantity={(i, val) =>
												(ingredient_list[i].quantity =
													val)}
											onChangeUnit={(i, val) =>
												(ingredient_list[i].unit_id =
													val)}
										/>
									{/each}
								</div>
							</List>
						{/each}
					</div>
				</div>
			</Cell>
			<Cell span={12}>
				<RfExtensions recipe_id={id} {ingredient_list} {alternates} />
			</Cell>
			<Cell span={12}>
				<Textfield
					bind:value={substitutions}
					label="Substitutions"
					class="recipe-substitutions-field"
					style="width: 100%;"
					helperLine$style="width: 100%;"
				/>
			</Cell>
		</LayoutGrid>
	</div>
</div>
<div>
	<Button onclick={saveRecipe} defaultAction>{id ? "Update" : "Save"}</Button>
	<Button
		onclick={() => {
			closeForm();
		}}
		color="secondary">Cancel</Button
	>
</div>

<style lang="scss">
	.recipe-ingredient-list {
		border: 1px solid #444;
		padding: 1.5rem;
		margin: 2.25rem 0 1rem 0;
		align-items: center;
		font-family: "Roboto";
		position: relative;

		.inner-ingredient-item {
			display: grid;
			grid-template-columns: 200px auto;
			&.editing {
				outline: 0 solid transparent;
			}
		}
		.end-button {
			display: flex;
			@media screen and (min-width: 838px) {
				justify-content: flex-end;
			}
		}

		&::before {
			content: "Ingredient List";
			position: absolute;
			display: block;
			border: 1px solid #555;
			top: -1rem;
			left: 0.5rem;
			background: white;
			padding: 0.25rem 1.5rem;
		}
	}
	.recipe-form {
		:global(.mdc-select, .mdc-text-field) {
			width: 100%;
		}
	}
	.recipe-sections {
		margin: 1rem 0;
	}
	.recipe-sections .sections-list {
		display: flex;
		flex-direction: column;
		gap: 0.5rem;
		margin: 0.5rem 0;
	}
	.recipe-sections .section-row {
		display: flex;
		gap: 0.5rem;
		align-items: center;
	}
	.recipe-sections .section-row input {
		flex: 1;
	}
	.recipe-sections .add-section {
		display: flex;
		gap: 0.5rem;
		align-items: center;
	}
</style>