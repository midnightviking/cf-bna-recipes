<script>
import Button, { Icon } from "@smui/button";
import Textfield from "@smui/textfield";
import Select, { Option } from "@smui/select";
import LayoutGrid, { InnerGrid, Cell } from '@smui/layout-grid';
import List, { Item, Graphic, Separator, Text, Meta, SecondaryText,PrimaryText, Subheader } from '@smui/list';
import {mdiDelete, mdiPlus, mdiClose, mdiKeyboardReturn, mdiPencilPlus} from '@mdi/js'
import IconButton from "@smui/icon-button";
import { goto, invalidate, invalidateAll } from "$app/navigation";
import { getContext, onMount, setContext } from "svelte";
import RfExtensions from "$lib/components/recipe_form/rf_extensions.svelte";
	import { useBannerActions } from "$lib/action-banner-state.svelte";


const itemTypes = ["bread", "veggie", "soup", "entree", "dessert","protein"];
const categories = ["breakfast","veggies", "starches", "entrees", "dessert"];

let new_ingredient = $state("");
let new_quantity = $state("");
let new_unit = $state("");
let ingSelected = $state("");
let {
	id = null,
	title = "",
	minTemp = "",
	itemType = "",
	portionSize = "",
	calories = "",
	category = "",
	instructions = "",
	ccp = "",
	substitutions = "",
	initialServings = 100,
	ingredients = [],
	selectedExtensions = [],
	alternates=[]
} = $props();
let ingredient_list = $state(ingredients);
let allIngredients = getContext("all_ingredients");
let units = getContext("units");

const addIngredientToRecipe = () => {
	if (
		!new_ingredient ||
		new_unit === "" ||
		new_quantity <= 0 ||
		new_quantity === ""
	)
		return;
	const ing = allIngredients.find((i) => i.id == new_ingredient);
	const unit = units.find((u) => u.id == new_unit);
	if (!ing || !unit) return;

	// Prevent duplicates
	if (ingredients?.some((i) => i.ingredient_id == new_unit)) return;
	let newIng = {
			ingredient_id: ing.id,
			name: ing.name,
			quantity: new_quantity,
			unit_id: unit.id,
			unit_name: unit.name,
		};
	ingredient_list = [...ingredient_list,newIng] ?? [newIng];
	
	//reset
	new_ingredient = "";
	new_unit = "";
	new_quantity = "";
};

const removeIngredientFromRecipe = (index) => {
	if (ingredient_list.length > 0) {
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
		category,
		instructions,
		ccp,
		substitutions,
		initialServings,
		ingredients: ingredient_list.map((i) => ({
			ingredient_id: i.ingredient_id,
			quantity: i.quantity,
			unit_id: i.unit_id,
		})),
		extensions: selectedExtensions,
		alternates: alternates.map(a => ({ ...a }))
	};

	if (id) {
		await fetch("/api/recipes", {
			method: "PUT",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify({ ...recipe, id: id }),
		}).then(async (res)=>{
			//success, now do the next thing
			goto("/recipes");
		});
	} else {
		await fetch("/api/recipes", {
			method: "POST",
			headers: { "Content-Type": "application/json" },
			body: JSON.stringify(recipe),
		}).then(async (res)=>{
			//success, now do the next thing
			// console.log('Success')
			goto("/recipes");
		});
	}
}

function resetForm() {
	id = null;
	title = "";
	minTemp = "";
	itemType = "";
	portionSize = "";
	calories = "";
	category = "";
	instructions = "";
	ccp = "";
	substitutions = "";
	initialServings = 100;
	ingredients = [];
	ingredient_list = [];
}

const banner_actions = [
		{label:id?"Update":"Save", icon: "", func: saveRecipe},
		{label:"Cancel", icon: "", func: ()=>{history.back()}}
	];

useBannerActions(banner_actions);


</script>

	<h3>
		{id ? "Edit " + title + "" : "Add"} Recipe
	</h3>
	<div id="recipe-dialog-content">
		<div class="recipe-form" style="width:100%;">

			<LayoutGrid>
				<!-- Recipe Name Row-->
				<Cell span={12}>
					
					<Textfield
					bind:value={title}
					helperLine$style="width: 100%;"
					label="Title"
					required
					class="recipe-title-field"
					/>
				</Cell>
	
				<!-- Recipe categorization-->
				<Cell spanDevices={{ desktop: 6, tablet: 4, phone: 4 }}>
					<Select
						bind:value={itemType}
						label="Item Type"
						class="recipe-item-type-field"
						
					>
						
						{#each itemTypes as type}
							<Option value={type.toLowerCase()}>{type.charAt(0).toUpperCase() + type.slice(1).toLowerCase()}</Option>
						{/each}
					</Select>
				</Cell>
				<Cell spanDevices={{ desktop: 6, tablet: 4, phone: 4 }}>
					<Select
						bind:value={category}
						label="Category"
						class="recipe-category-field"
						style="width: 100%;"
					>
						<!-- <Option value="" disabled selected>Select category</Option> -->
						{#each categories as cat}
							<Option value={cat}>{cat.charAt(0).toUpperCase() + cat.slice(1).toLowerCase()}</Option>
						{/each}
					</Select>
				</Cell>
				
				<!-- Recipe stats -->
				<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 4 }}>
					<Textfield
						bind:value={portionSize}
						label="Portion Size"
						class="recipe-portion-size-field"
					/>
				</Cell>
				<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 4 }}>
					<Textfield
						bind:value={calories}
						label="Calories"
						
						class="recipe-calories-field"
					/>
				</Cell>
				<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 4 }}>
					<Textfield
						bind:value={minTemp}
						label="Minimum Temp (F)"					
						class="recipe-min-temp-field"
					/>
				</Cell>
				
				
				<!-- Recipe Instructions -->
				<Cell span={12}>
					<Textfield
						bind:value={instructions}
						label="Cooking Instructions"
						textarea
						class="recipe-instructions-field"
						style="width: 100%;"
						helperLine$style="width: 100%;"
					/>
				</Cell>
				
				<!-- Recipe Safety -->
				<Cell span={12}>
					<Textfield
						bind:value={ccp}
						textarea
						label="Critical Control Point (CCP)"
						class="recipe-ccp-field"
						style="width: 100%;"
						helperLine$style="width: 100%;"
					/>
					<!-- check box for use generic, only show textfield if unchecked?-->
				</Cell>
				<Separator />
				<Cell span={12}>
					<strong>Ingredients</strong>
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
	
								<Cell  spanDevices={{ desktop: 4, tablet: 8, phone: 4 }}>
	<!-- update to combobox later-->
									<Select
										key={(ing) => `${ing ? ing.id : ""}`}
										bind:value={new_ingredient}
										label="Select Ingredient"
										>
										<!-- <Option value="">Select ingredient</Option> -->
										{#each allIngredients as ing}
										<Option value={ing.id}>{ing.name}</Option>
										{/each}
									</Select>
								</Cell>
								<Cell  spanDevices={{ desktop: 2, tablet: 4, phone: 2}}>
									<Textfield
										bind:value={new_quantity}
										label="Quantity"
										type="number"
										min="0"
										step="2"
										input$step="2"

									/>
								</Cell>
								<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 2 }}>
									<Select
										key={(unit) => `${unit ? unit.name : ""}`}
										bind:value={new_unit}
										label="Unit"
									>
										<!-- <Option value="">Select unit</Option> -->
										{#each units as u}
											<Option value={u.id}>{u.name}</Option>
										{/each}
									</Select>
								</Cell>
	
								<Cell span={2} spanDevices={{ desktop: 2, tablet: 12, phone: 4}} align="middle" style="align-content:end;">
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
						<div class="recipe-ingredient-list">
							<List
								selectedIndex={ingSelected}
								singleSelection
							>
								{#each ingredient_list as ing, index}
									<Item >
										<Text>
											<div class="inner-ingredient-item {ingSelected === index? 'editing':''}" >
												<strong>
													{ing.name}
												</strong>
												{#if ingSelected === index && ingSelected !== -1}
													<div class="edit-area">
														<input
														type="number"
														bind:value={ingredient_list[index].quantity}
														style="width: 60px;"
														min="0"
													/>
														<select
															bind:value={ingredient_list[index].unit_id}
															
															>
															{#each units as u}
																<option value={u.id}>{u.name}</option>
															{/each}
														</select>
													</div>
												{:else}
													<span>
														{ing.quantity}
														{ing.unit_name}{ing.unit_name.endsWith('s') ? '' : '(s)'}
													</span>
												{/if}
											</div>
										</Text>
										<Meta>
											<div class="end-button" style="display:flex;gap:0.5rem;">
												{#if ingSelected === index}
													<Button
														onclick={() => (ingSelected = false)}
														variant="outlined"
													>
														Save
													</Button>
												{:else}
													<Button
														onclick={() => (ingSelected = index)}
														variant="outlined"
													>
														Edit
													</Button>
												{/if}
												
												<Button
													onclick={() => removeIngredientFromRecipe(index)}
													color="secondary"
													variant="outlined"
												>
													<Icon tag="svg" viewBox="0 0 24 24">
														<path fill="currentColor" d={mdiDelete} />
													</Icon>													
												</Button>

											</div>
										</Meta>
									</Item>
								<Separator />
								{/each}
							</List>
						</div>
					</div>
				</Cell>
				<Cell span={12}>
					<RfExtensions
						recipe_id={id}
						ingredient_list={ingredient_list}
						alternates={alternates}
					/>
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
		<Button onclick={()=>{resetForm(); closeForm();}} color="secondary">Cancel</Button>
	</div>



<style lang="scss">
	.recipe-ingredient-list{
		border:1px solid #444;
		padding:1.5rem;
		margin:2.25rem 0 1rem 0;
		align-items: center;
		font-family: "Roboto";
		position: relative;
		
		.inner-ingredient-item{
			display:grid; 
			grid-template-columns:200px auto;
			&.editing{
				
				.edit-area{
					// border:1px solid;
				}
			}
		}
		.end-button{
			display:flex;
			@media screen and (min-width:838px) {
				justify-content: flex-end;
				
			}
		}

		&::before{
			content:"Ingredient List";
			position:absolute;
			display: block;
			border:1px solid #555;
			top:-1rem;
			left:0.5rem;
			background:white;
			padding:0.25rem 1.5rem;
		}
		

	}
	.recipe-form{

		:global(.mdc-select, .mdc-text-field){
			width:100%;
		}
			
	}
</style>