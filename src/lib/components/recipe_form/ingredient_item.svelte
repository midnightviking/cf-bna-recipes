
<Item 	
	draggable={true}
	ondragstart={handleDragStart}
	ondragover={handleDragOver}
	ondrop={handleDrop}
>
	<Text>
		<div class="inner-ingredient-item {isSelected === _flatIndex? 'editing':''}">
			<strong>{name}</strong>
			{#if isSelected}
				
				<div class="edit-area">
					<input type="number" bind:value={quantity} style="width:60px;" min="0" step="2" />
					
					<!-- <select bind:value={ingredient_list[ing._flatIndex].unit_id}>
						{#each units as u}<option value={u.id}>{u.name}</option>{/each}
					</select>

					<select onchange={(e) => {
						const val = e.currentTarget.value;
						const sec = section_list.find(ss => String(secKey(ss)) === val || ss.name === val);
						if (!val) { ingredient_list[ing._flatIndex].section_id = null; delete ingredient_list[ing._flatIndex].section; }
						else if (sec && typeof sec.id === 'number') { ingredient_list[ing._flatIndex].section_id = sec.id; delete ingredient_list[ing._flatIndex].section; }
						else { ingredient_list[ing._flatIndex].section_id = undefined; ingredient_list[ing._flatIndex].section = val; }
					}}>
						<option value="">No section</option>
						{#each section_list as s}<option value={secKey(s)} selected={(ingredient_list[ing._flatIndex].section_id ?? ingredient_list[ing._flatIndex].section) === secKey(s)}>{s.name}</option>{/each}
					</select> -->
				</div>
			{:else}
				<span>{quantity}{unit_name}</span>
			{/if}
		</div>
	</Text>
	<Meta>
		<div class="end-button" style="display:flex;gap:0.5rem;">
			{#if isSelected}
				<Button onclick={saveFunc} variant="outlined">Save</Button>
			{:else}
			{/if}
			<Button onclick={editFunc} variant="outlined">Edit</Button>
			<Button onclick={removeFunc} color="secondary" variant="outlined">
				<Icon tag="svg" viewBox="0 0 24 24"><path fill="currentColor" d={mdiDelete} /></Icon>
			</Button>
		</div>
	</Meta>
</Item>

<script>
	import { mdiDelete } from "@mdi/js";
	import Button, { Icon } from "@smui/button";
	import List, { Item, Meta, Text } from "@smui/list";

	let{
		handleDragOver=()=>{},
		handleDragStart=()=>{},
		handleDrop=()=>{},
		editFunc=()=>{},
		removeFunc=()=>{},
		saveFunc=()=>{},
		isSelected=$bindable(-1),
		name=$bindable(""),
		quantity=$bindable(""),
		unit_name=$bindable(""),
		_flatIndex=$bindable(-1),


	}=$props();
	$inspect(isSelected)
</script>