<script>
	import { onMount } from 'svelte';
	import { invalidate, invalidateAll } from '$app/navigation';

	import Textfield from '@smui/textfield';
	import HelperText from '@smui/textfield/helper-text';
	
	import Fab from '@smui/fab';	
	import Button, { Label } from '@smui/button';
	import IconButton, { Icon } from '@smui/icon-button';
	import Dialog, {Header,Content, Title} from '@smui/dialog';

	import Editable from '$lib/components/Editable.svelte';
	import {mdiDelete, mdiPlus, mdiClose} from '@mdi/js'
	import { fade } from 'svelte/transition';

	let {data} = $props();
	let {all_units} = data;
	let units = $state([]);
	units = all_units;
	
	let editingUnit = $state(false);
	let editingIndex = -1;
	let showForm = $state(false);

	let name = $state('');
	let conversion_unit = $state('');
	let conversion_threshold = $state('');
	let conversion_formula = $state('');

	function resetForm() {
		name = '';
		conversion_unit = '';
		conversion_threshold = '';
		conversion_formula = '';
		
	}

	function openForm(unit = null, i=-1) {
		showForm = true;
		if (unit) {
			editingIndex = i;
			editingUnit = unit;
			name = unit.name;
			conversion_unit = unit.conversion_unit;
			conversion_threshold = unit.conversion_threshold ?? '';
			conversion_formula = unit.conversion_formula ?? '';
		} else {
			resetForm();
		}
	}

	function closeForm() {
		showForm = false;
		resetForm();
	}

	async function saveUnit(unit=null) {
		const payload = { name, conversion_unit, conversion_threshold, conversion_formula };
		if (editingUnit) {
			await fetch('/api/units', {
				method: 'PUT',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ id: editingUnit.id, ...payload })
			})
			.then(async (res)=>{
				if(res?.status === 200){
					let up = await res.json();
					if(units[editingIndex]){
						units[editingIndex] = up;
						editingIndex = -1;
						editingUnit = -1;
					}
				}
			});


		} else {
			await fetch('/api/units', {
				method: 'POST',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify(payload)
			}).then(async(res)=>{
				if(res.status===201){
					let u = await res.json();
					units.push(u);
				}else{
					console.log(res);
				}

			});
			
		}
		invalidate();
		closeForm();
	}

	async function removeUnit(index) {
		let id = units[index]?.id;
		if(id){

			await fetch('/api/units', {
				method: 'DELETE',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ id })
			}).then((res)=>{
				if(res.status === 200){
					units.splice(index, 1);
					invalidate();
				}
			});
		}
		
	}

</script>

<h1>Units</h1>
<Fab class="add-unit" type="button" onclick={() => openForm()} extended
	style="position:fixed; right:0; bottom:20px"
	>
	<Icon tag="svg" viewBox="0 0 24 24">
		<path fill="currentColor" d={mdiPlus} />
	</Icon>
	<Label>
		Add Unit
	</Label>
</Fab>
<div class="unit-list">
	{#if units?.length === 0}
		<p>No units found.</p>
	{/if}
	{#each units as unit, i}
		{#key unit}
			<div class="unit-list-item" transition:fade>
				<Editable
					title={unit.name?.toUpperCase()}
					onEdit={()=>openForm(unit, i)}
					onDelete={()=>removeUnit(i)}
					>
					<div class="unit-content">
						{#if unit?.conversion_unit}
							<div class="unit-conversion-unit">
								
									<strong>Converts to:</strong> {unit.conversion_unit}
								
							</div>
						{/if}
						{#if unit?.conversion_threshold}<div class="unit-conversion-threshold"><strong>Threshold:</strong> {unit.conversion_threshold}</div>{/if}
						{#if unit?.conversion_formula}<div class="unit-conversion-formula"><strong>Formula:</strong> {unit.conversion_formula}</div>{/if}
					</div>
				</Editable>
			</div>
		{/key}
	{/each}
</div>

<Dialog
	bind:open={showForm}
	scrimClickAction=""
	escapeKeyAction=""
	aria-labelledby="unit-dialog-title"
	aria-describedby="unit-dialog-content"
	fullscreen
>
	<Header>
		<Title id="unit-dialog-title">
			{editingUnit ? "Edit " + name + "" : "Add"} Unit			
		</Title>
		<IconButton action="close" class="material-icons" onclick={()=>{resetForm(); closeForm();}}>
			<Icon tag="svg" viewBox="0 0 24 24">
				<path fill="currentColor" d={mdiClose} />
			</Icon>
		</IconButton>
	</Header>
	<Content id="unit-dialog-content">
		<div class="unit-form">
			<Textfield bind:value={name} label="Unit Name" required class="unit-name-field"
			variant="outlined"
			/>
			<div>
				<br/>
				<strong>Scaling conversion</strong><br/>
				<small>If the unit is on the smaller side, it might be good to assign a larger one for easier readability</small>
				<hr/>
			</div>
			<Textfield
				bind:value={conversion_unit}
				label="Conversion Unit"
				class="unit-conversion-unit-field"
				variant="outlined"
			>
				{#snippet helper()}
					<HelperText persistent>
						What unit is displayed if the values go above the Threshold? e.g quarts to gallons.
					</HelperText>
				{/snippet}
			</Textfield>
			
			<Textfield
				bind:value={conversion_threshold}
				label="Conversion Threshold"
				type="number"
				class="unit-conversion-threshold-field"
				variant="outlined"
			>
				{#snippet helper()}
					<HelperText persistent>
						What threshold to convert to the next unit? <br> e.g after 8 quarts, show in gallons.
					</HelperText>
				{/snippet}
			</Textfield>
			
			<Textfield
				bind:value={conversion_formula}
				label="Conversion Formula"
				class="unit-conversion-formula-field"
				type="number"
				variant="outlined"
			>
				{#snippet helper()}
					<HelperText persistent>
						What is the denominator to use when performing the conversion?<br/> e.g. quarts/<strong>4</strong> to gallons. <br/>
						
					</HelperText>
				{/snippet}
			</Textfield>
			
			<div class="form-actions">
				<Button onclick={saveUnit}>{editingUnit ? 'Update' : 'Save'}</Button>
				<Button onclick={closeForm} color="secondary">Cancel</Button>
			</div>
		</div>
	</Content>
</Dialog>


<style lang="scss">
	.unit-form{
		margin:1rem 0;
		display: flex;
		flex-direction: column;
		gap:.4rem 0;
		
		:global(.mdc-text-field-helper-text){
			margin-bottom:1rem;
		}
	}
	.unit-list{
		display:flex;
		flex-direction: column;
		align-items: start;

		.unit-list-item{
			min-width: 250px;
			margin-bottom:1rem;


			.unit-content{
				> div{
					display:grid;
					grid-template-columns: 1fr 1fr;
					&:nth-child(even){
						background:rgba(0,0,0,0.1);
					}
				}
			}
		}
	}
</style>
