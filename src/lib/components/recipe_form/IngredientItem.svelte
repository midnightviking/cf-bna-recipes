<script>
	import { Item, Text, Meta } from "@smui/list";
	import Button, { Icon } from "@smui/button";
	import { mdiDelete } from "@mdi/js";
	import { getContext } from "svelte";
	import IconButton from "@smui/icon-button";

	let {
		ing,
		index,
		_localIndex,
		ingSelected = -1,

		onEdit = () => {},
		onSave = () => {},
		onRemove = () => {},
		onChangeQuantity = () => {},
		onChangeUnit = () => {},
		handleMove = () => {},

		section_id = -1,
	} = $props();
	//   console.log(index, ing)
	let units = getContext("units") ?? [];
</script>

<Item data-id={_localIndex} draggable={true} >
	<Text>
		<div
			class="inner-ingredient-item {ingSelected === index
				? 'editing'
				: ''}"
		>
			<IconButton ripple={false} >
				<Icon>
					<svg viewBox="0 0 24 24" aria-hidden="true">
						<path
							fill="currentColor"
							d="M9 3H7v2h2V3m0 4H7v2h2V7m0 4H7v2h2v-2m0 4H7v2h2v-2m8-8h-2v2h2V7m0-4h-2v2h2V3m0 8h-2v2h2v-2m0 4h-2v2h2v-2Z"
						/></svg
					>
				</Icon>
			</IconButton>

			<strong>{ing.name}</strong>
			{#if ingSelected === index && ingSelected !== -1}
				<div class="edit-area">
					<input
						type="number"
						value={ing.quantity}
						min="0"
						style="width:60px;"
						oninput={(e) =>
							onChangeQuantity(
								index,
								Number(e.currentTarget.value)
							)}
					/>&nbsp;
					<select
						value={ing.unit_id}
						onchange={(e) =>
							onChangeUnit(index, Number(e.currentTarget.value))}
					>
						{#each units as u}
							<option value={u.id}>{u.name}</option>
						{/each}
					</select>
				</div>
			{:else}
				<span>{ing.quantity}&nbsp;{ing.unit_name}</span>
			{/if}
		</div>
	</Text>
	<Meta>
		<div class="end-button" style="display:flex;gap:0.5rem;">
			{#if ingSelected === index}
				<Button onclick={() => onSave(index)} variant="outlined"
					>Save</Button
				>
			{:else}
				<Button onclick={() => onEdit(index)} variant="outlined"
					>Edit</Button
				>
			{/if}
			<Button
				onclick={() => onRemove(index)}
				color="secondary"
				variant="outlined"
			>
				<Icon tag="svg" viewBox="0 0 24 24"
					><path fill="currentColor" d={mdiDelete} /></Icon
				>
			</Button>
		</div>
	</Meta>
</Item>

<style lang="scss">
	.inner-ingredient-item {
		display: grid;
		grid-template-columns: auto 200px auto;
		align-items: center;
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
</style>
