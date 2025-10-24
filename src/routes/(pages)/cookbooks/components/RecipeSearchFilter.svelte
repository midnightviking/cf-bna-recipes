<script>
	import Textfield from '@smui/textfield';
	import { mdiMagnify } from '@mdi/js';

	let { searchTerm = $bindable(''), onSearch } = $props();

	function handleSearch(e) {
		searchTerm = e.target.value;
		onSearch?.(searchTerm);
	}

	function handleClear() {
		searchTerm = '';
		onSearch?.('');
	}
</script>

<div class="recipe-search-filter">
	<Textfield
		bind:value={searchTerm}
		label="Search recipes..."
		class="search-input"
		style="width: 100%;"
		input$style="width: 100%"
		on:input={handleSearch}
	>
		<span slot="leadingIcon">
			<svg viewBox="0 0 24 24" width="20" height="20" aria-hidden="true">
				<path fill="currentColor" d={mdiMagnify} />
			</svg>
		</span>
	</Textfield>
	{#if searchTerm}
		<button class="clear-search" title="Clear search" onclick={handleClear}>
			✕
		</button>
	{/if}
</div>

<style lang="scss">
	.recipe-search-filter {
		position: relative;
		margin-bottom: 1em;
		display: flex;
		gap: 0.5em;
		align-items: center;
	}

	.clear-search {
		position: absolute;
		right: 0.5em;
		top: 50%;
		transform: translateY(-50%);
		background: none;
		border: none;
		cursor: pointer;
		padding: 0.25em;
		color: #999;
		font-size: 1.2em;
		line-height: 1;

		&:hover {
			color: #333;
		}
	}
</style>
