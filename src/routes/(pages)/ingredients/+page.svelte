<script>
	import { onMount } from "svelte";
	import Button, { Icon } from "@smui/button";
	import Textfield from "@smui/textfield";
	import Select from "@smui/select";
    import Card, {Content, Actions} from "@smui/card";
    import List, {Item, Text, Graphic, Meta} from "@smui/list";
    import {mdiCircleEditOutline, mdiDelete} from "@mdi/js";
	import { invalidate } from "$app/navigation";
	let { data, form } = $props();
	let ingredients = $state([]);
	ingredients = data?.ingredients;
    $inspect(form);

    async function deleteIngredient(id){
        if(!id) return;
        await fetch('/api/ingredients', {
            method: 'DELETE',
				headers: { 'Content-Type': 'application/json' },
				body: JSON.stringify({ id })
			}).then((res)=>{
				if(res.status === 200){
					ingredients?.splice(index, 1);
					invalidate();
				}
			});
    }

</script>

{#if ingredients?.length === 0}
	<p>Loading ...</p>
{/if}
<div class="ingredient-list">

    {#key ingredients}
    <List class="zebra-list" nonInteractive>

        {#each ingredients as ingredient, i}
        <Item>
            {#if ingredient?.editing}
            <form method="POST" action="?/save"><Text>
                
                    <button  onclick={() => { /* Optionally save changes here */ }}>
                        Save
                    </button>
                
                    <input type="hidden" value={ingredient.id} name="id"/>
                    <!-- <input type="text" name="name" value={ingredient.name} /> -->
                   <Textfield bind:value={ingredient.name}
                    variant="outlined"
                    style="width:100%;background-color:#fff; border-color:black; height:40px"
                    helperLine$style="width: 100%;"
                    input$name="name"
                    
                /> 
                </Text>
            </form>
            {:else}
                <Graphic>
                    <Button onclick={() => {  ingredient.editing = true; }}>
                        <Icon tag="svg" viewBox="0 0 24 24">
                            <path fill="currentColor" d={mdiCircleEditOutline} />
                        </Icon>
                    </Button>
                </Graphic>
                <Text>
                    <p>
                        {ingredient.name}
                    </p>
                </Text>
            
            {/if}
            <Meta>
                <Button onclick={()=>{
                    deleteIngredient(ingredient?.id)
                }} >
                    <Icon tag="svg" viewBox="0 0 24 24">
						<path fill="currentColor" d={mdiDelete} />
					</Icon>
                </Button>
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