<script>
import Fab from '@smui/fab';
import { mdiPlus } from '@mdi/js';

    import { onMount } from "svelte";
    import Button, { Icon } from "@smui/button";
    import Textfield from "@smui/textfield";
    import Select from "@smui/select";
    import Card, {Content, Actions} from "@smui/card";
    import List, {Item, Text, Graphic, Meta} from "@smui/list";
    import {mdiCircleEditOutline, mdiDelete} from "@mdi/js";
    import { invalidate } from "$app/navigation";
    import {enhance} from "$app/forms";
	import { bannerActions, useBannerActions } from '$lib/action-banner-state.svelte.js';
    let { data, form } = $props();
    let extensions = $state(data?.extensions ?? []);
    let sorted = $derived(extensions.toSorted((a,b)=>a?.name.localeCompare(b?.name)));

    function addRestriction() {
        extensions.unshift({ id: undefined, name: '', editing: true });
    }

    const banner_actions = [
		{ label: "Add New Dietary Extension", icon: "", func: addRestriction },
		
	];

	useBannerActions(banner_actions);
</script>
<Fab extended type="button" onclick={addRestriction} style="position:fixed; right:0; bottom:20px; z-index:7">
    <Icon tag="svg" viewBox="0 0 24 24">
        <path fill="currentColor" d={mdiPlus} />
    </Icon>
    <span>Add Dietary Extension</span>
</Fab>
{#if extensions?.length === 0}
    <p>No dietary extensions added.</p>
{/if}
<div class="ingredient-list">

    {#key sorted}
    <List class="zebra-list" nonInteractive>

        {#each sorted as restriction, i}
        <Item>
            {#if restriction?.editing}
            <form method="POST" action={restriction.id ? '?/save': '?/add'}><Text>
                
                    <button  onclick={() => { /* Optionally save changes here */ }}>
                        Save
                    </button>
                
                    <input type="hidden" value={restriction.id} name="id"/>
                    <!-- <input type="text" name="name" value={ingredient.name} /> -->
                   <Textfield bind:value={restriction.name}
                    variant="outlined"
                    style="width:100%;background-color:#fff; border-color:black; height:40px"
                    helperLine$style="width: 100%;"
                    input$name="name"
                    
                /> 
                </Text>
            </form>
            {:else}
                <Graphic>
                    <Button onclick={() => {  restriction.editing = true; }}>
                        <Icon tag="svg" viewBox="0 0 24 24">
                            <path fill="currentColor" d={mdiCircleEditOutline} />
                        </Icon>
                    </Button>
                </Graphic>
                <Text>
                    <p>
                        {restriction.name}
                    </p>
                </Text>
            
            {/if}
            <Meta>

                  <form
                    action="?/delete"
                    method="POST"
                    use:enhance={() => {
                    return ({ form, result }) => {
                        if (result.type === 'success') {
                            extensions = extensions.filter(e => e.id !== restriction.id);
                        }
                    };
                    }}
                >
                    <input type="hidden" name="id" value={restriction?.id}>
                    <Button>

                        <Icon tag="svg" viewBox="0 0 24 24">
                            <path fill="currentColor" d={mdiDelete} />
                        </Icon>
                    </Button>
                </form>

                <!-- <Button onclick={()=>{
                    deleteRestriction(restriction?.id)
                }} >
                    <Icon tag="svg" viewBox="0 0 24 24">
                        <path fill="currentColor" d={mdiDelete} />
                    </Icon>
                </Button> -->
            </Meta>
        </Item>
        {/each}
    </List>
    {/key}
</div>

<style lang="scss">
    .ingredient-list{
       /*  display:flex;
        flex-direction: column;
        align-items: flex-start; */
        
    }
    :global(.mdc-deprecated-list-item){
        justify-content: inherit !important;
    }
    :global(.mdc-deprecated-list-item__text){
        // border:1px solid brown;
        flex:1 0;
    }
    :global(.zebra-list > li:nth-child(even) ) {
        
            background:rgba(0,0,0,0.15);
        
    }
</style>