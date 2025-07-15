<Card class="editable-card" >
	<Content class="mdc-typography--body2">
		<PrimaryAction onclick={()=>{showChild = !showChild}}>
			<div class="card-title">
				<h4>{title}</h4>
			</div>
			{#if subcontent}
			<div class="card-sub">
				<p>
					{subcontent}
				</p>
			</div>
			{/if}
		</PrimaryAction>
		{#if children && showChild}
			{@render children?.()}
		{/if}
		<Actions style="padding:0">
			<ActionButtons class={spreadActions ? "spread-actions": ""}>
				{#if onEdit}
				<Button variant="raised" bind:onclick={onEdit}>
					<Icon tag="svg" viewBox="0 0 24 24">
						<path fill="currentColor" d={mdiPencil} />
					</Icon>
					<Label>Edit</Label>
				</Button>
				{/if}
				{#if onDelete}
				<Button color="secondary" bind:onclick={onDelete} class="delete-button">
					<Icon tag="svg" viewBox="0 0 24 24">
						<path fill="currentColor" d={mdiFileDocumentRemoveOutline} />
					</Icon>
					<Label>
						Delete
					</Label>
				</Button>
				{/if}
			</ActionButtons>
		</Actions>
	</Content>
</Card>

<script>
	import Button, { Icon, Label } from "@smui/button";
	import Textfield from "@smui/textfield";
	import Select, { Option } from "@smui/select";
	import Card, {
		Content,
		PrimaryAction,
		Actions,
		ActionButtons,
		ActionIcons,
	} from "@smui/card";
	
	import IconButton from "@smui/icon-button";
    import { mdiFileDocumentRemoveOutline, mdiPencil } from '@mdi/js';
	let {
		title = "",
		onEdit = ()=>{},
		onDelete = ()=>{},
		subcontent = "",
		primary = ()=>{},
		spreadActions = true,
		children
	} = $props();

	let showChild = $state(true);
</script>

<style lang="scss">
	.card-title{
      
      h4{
        font-family:'Roboto';
        font-size: 1.2rem;
        /* font-weight: 600; */
		margin:0;
        margin-bottom:0.25em;
      }
      &::after{
        content:'';
        width: 100px;
        height:4px;
        display: block;
        margin-bottom:0.4rem;
        background:var(--mdc-theme-primary, #222);
        
      }
    }

	:global(.spread-actions){
		width: 100%;
		justify-content: space-between;
	}
</style>