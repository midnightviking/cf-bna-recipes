<script>
	import { mdiChevronDown, mdiChevronUp } from '@mdi/js';
	import Accordion, { Content, Header, Panel } from '@smui-extra/accordion';
	import Button from '@smui/button';
	import IconButton, { Icon } from '@smui/icon-button';
	import Select, { Option } from '@smui/select';
    import {goto} from '$app/navigation';
    let { data } = $props();
    let {cookbooks} = data;

    let sortMode = $state("added");

</script>

<h2>Menus</h2>
{#if cookbooks.length === 0}
	<p>No menus found.</p>
{:else}
    <Accordion>
        {#each cookbooks as menu, id}
            <Panel bind:this={menu.panelRef}>
                <Header>
                    <div class="menu-title">{menu.name}</div>
                    {#snippet description()}
                        <div class="menu-description">
                            {menu.description}
                        </div>
                    {/snippet}
                    {#snippet icon()}
							<IconButton
								toggle
								pressed={menu.panelRef?.isOpen()}
							>
								<Icon tag="svg" viewBox="0 0 24 24" on>
									<path
										fill="currentColor"
										d={mdiChevronDown}
									/>
								</Icon>
								<Icon tag="svg" viewBox="0 0 24 24">
									<path
										fill="currentColor"
										d={mdiChevronUp}
									/>
								</Icon>
							</IconButton>
						{/snippet}
                </Header>
                <Content>
						<Button onclick={()=>{goto(`cookbooks/edit/${menu.id}`)}}>Edit</Button>
						<Button color="error">Delete</Button>
						<a
							class="mdc-button"
							href="/menu/{menu.id}"
							color="secondary">Print outs</a
						>
						<div class="cookbook-sort">
							<label for="cookbook-sort-select">Sort:</label>
							<Select
								id="cookbook-sort-select"
								bind:value={sortMode}
								class="cookbook-sort-select"
							>
								<Option value="added">Order Added</Option>
								<Option value="alpha">Alphabetical</Option>
								<Option value="category">By Category</Option>
							</Select>
						</div>
						<ul class="menu-recipe-list">
							{#each menu?.recipes as recipe}
                                <li>
									<a
										href={`/recipes/edit/${recipe.id}`}
									>
										{recipe?.title}
									</a>
                                </li>
                            {/each}
							
						</ul>
					</Content>
            </Panel>
        {/each}
    </Accordion>
{/if}

<style lang="scss">
    .menu-recipe-select {
		display: flex;
		flex-direction: column;
	}
	.menu-list {
		margin-bottom: 1rem;
	}
	.menu-card {
		border: 1px solid #ccc;
		/* padding: 1rem; */
		margin-bottom: 1.5rem;
		border-radius: 4px;
		background: #f9f9f9;
	}
	.menu-title {
		font-weight: normal;
		font-size: 1.2em;
		font-family: "Roboto";
	}
	.menu-description {
		color: #666;
		margin-bottom: 0.5em;
	}
</style>