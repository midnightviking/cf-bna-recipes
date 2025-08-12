<script>
		import Banner from "@smui/banner";
		import Button, { Label } from "@smui/button";
		import { onDestroy } from 'svelte';
		import { bannerActions } from "$lib/action-banner-state.svelte.js";
		let banner_actions = $state([]);
		const unsubscribe = bannerActions.subscribe(v => banner_actions = v);
		onDestroy(unsubscribe);
		let data = $props();
		// Actions are provided via shared state from pages
</script>

<Banner autoClose={false} fixed={true} open={true}>
	{#snippet actions()}
			{#each banner_actions?.filter(a => a && typeof a === 'object') as action}
				<Button onclick={() => action.func && action.func()}>{action.label ?? 'Action'}</Button>
			{/each}
    {/snippet}
</Banner>

