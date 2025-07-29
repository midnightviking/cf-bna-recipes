<script>
	import Banner from "@smui/banner";
	import Button, {Label} from "@smui/button";

	import { getActionBannerState } from "$lib/action-banner-state.svelte";
	

	const banner_actions = $derived(getActionBannerState()?.getActions());
	
</script>

<Banner autoClose={false} fixed={true} open={true}>
	{#snippet actions()}
      {#each banner_actions as action}
	  	<Button onclick={action.func}>{action.label}</Button>
	  {/each}
    {/snippet}
</Banner>

