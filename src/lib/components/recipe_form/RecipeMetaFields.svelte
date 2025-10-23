<script>
	import Textfield from "@smui/textfield";
	import Select, { Option } from "@smui/select";
	import LayoutGrid, { Cell } from "@smui/layout-grid";
	import { Separator } from "@smui/list";
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
	let {
		title,
		itemType,
		category,
		portionSize,
		calories,
		protein,
		minTemp,
		instructions,
		ccp,
		substitutions,
		initialServings,
		
		
	} = $props();
</script>

<LayoutGrid>
	<!-- Recipe Name Row-->
	<Cell span={12}>
		<Textfield
			bind:value={title}
			helperLine$style="width: 100%;"
			label="Title"
			required
			class="recipe-title-field"
			style="width:100%"
		/>
	</Cell>
	
	<!-- Recipe categorization-->
	<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 4 }}>
		<Select
			bind:value={itemType}
			label="Item Type"
			class="recipe-item-type-field"
		>
			{#each itemTypes as type}
				<Option value={type.toLowerCase()}
					>{type.charAt(0).toUpperCase() +
						type.slice(1).toLowerCase()}</Option
				>
			{/each}
		</Select>
	</Cell>
	<Cell spanDevices={{ desktop: 4, tablet: 4, phone: 4 }}>
		<Select
			bind:value={category}
			label="Category"
			class="recipe-category-field"
			style="width: 100%;"
		>
			<!-- <Option value="" disabled selected>Select category</Option> -->
			{#each categories as cat}
				<Option value={cat}
					>{cat.charAt(0).toUpperCase() +
						cat.slice(1).toLowerCase()}</Option
				>
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
					bind:value={protein}
					label="Protein (g)"
					class="recipe-protein-field"
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
			input$rows={6}
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
			input$rows={4}
		/>
		<!-- check box for use generic, only show textfield if unchecked?-->
	</Cell>
	<Separator />
</LayoutGrid>

<style lang="scss">
</style>
