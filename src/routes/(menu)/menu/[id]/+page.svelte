<script>
	import { onMount, setContext } from "svelte";
	import RecipePrintTemplate from "$lib/components/RecipePrintTemplate.svelte";
	import { page } from "$app/stores";
	// import "../../styles.scss";
	import PrintPdf, { Page } from "svelte-printpdf";
	import Button from "@smui/button";
	import Select, { Option } from "@smui/select";
	import Checkbox from "@smui/checkbox";
	import FormField from "@smui/form-field";
	import LinearProgress from "@smui/linear-progress";
	import MetricsPanel from "$lib/components/MetricsPanel.svelte";
	let data = $props();
	let { units, extensions, cookbook } = data.data;
	setContext("units", units);

	let print = $state(false);

	let scales = [
		[10, 20, 30, 40, 50, 60, 70, 80, 90, 100],
		[
			100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220,
			230, 240, 250,
		],
		[
			250, 260, 270, 280, 290, 300, 310, 320, 330, 340, 350, 360, 370,
			380, 390, 400,
		],
		[
			400, 410, 420, 430, 440, 450, 460, 470, 480, 490, 500, 510, 520,
			530, 540, 550,
		],
		[
			550, 560, 570, 580, 590, 600, 610, 620, 630, 640, 650, 660, 670,
			680, 690, 700,
		],
		[
			700, 710, 720, 730, 740, 750, 760, 770, 780, 790, 800, 810, 820,
			830, 840, 850,
		],
		[
			850, 860, 870, 880, 890, 900, 910, 920, 930, 940, 950, 960, 970,
			980, 990, 1000,
		],
		[
			1000, 1010, 120, 130, 140, 150, 160, 170, 180, 190, 200, 210, 220,
			230, 240, 1150,
		],
		[
			1150, 1160, 1170, 1180, 1190, 1200, 1210, 1220, 1230, 1240, 1250,
			1260, 1270, 1280, 1290, 1300,
		],
		[
			1300, 1310, 1320, 1330, 1340, 1350, 1360, 1370, 1380, 1390, 1400,
			1410, 1420, 1430, 1440, 1450,
		],
		[
			1450, 1460, 1470, 1480, 1490, 1500, 1510, 1520, 1530, 1540, 1550,
			1560, 1570, 1580, 1590, 1600, 1610,
		],
	];

	let selected_scales = $state([1]);
	let selected_ext = $state([]);

	const getExtensions = () => {};
</script>

<div class="options-shelf">
	<h3>Recipe Scale</h3>
	<div class="scale-selection">
		{#each scales as scale, i}
			<FormField class="checkfield">
				<Checkbox bind:group={selected_scales} value={i} />
				{#snippet label()}
					{scale[0]}-{scale[scale.length - 1]}
				{/snippet}
			</FormField>
		{/each}
	</div>
	<hr />
	<h3>
		Dietary Extensions <strong style="color:red;"
			>(WIP, IRGNORE FOR NOW)</strong
		>
	</h3>
	<div class="scale-selection">
		{#each extensions as extension, i}
			<FormField class="checkfield">
				<Checkbox bind:group={selected_ext} value={i} touch />
				{#snippet label()}
					{extension.name}
				{/snippet}
			</FormField>
		{/each}
	</div>
	<div>
		<Button
			onclick={() => {
				selected_scales = [];
			}}>Clear</Button
		>
		<Button
			onclick={() => {
				print = true;
			}}>Print</Button
		>
	</div>
	<br />
	<div>
		{#await cookbook}<LinearProgress indeterminate />{/await}
	</div>
</div>

<PrintPdf bind:print>
	{#await cookbook then}
		{#each cookbook.recipes as recipe}
			{#each selected_scales.sort() as scale}
				<Page>
					<RecipePrintTemplate {recipe} scale={scales[scale]} />
				</Page>

				{#each selected_ext as ext}
					{#if recipe.extensions && recipe.extensions.some((e) => e.id === extensions[ext].id)}
						<!-- selected dietary extensions with replaced ingredients -->
						<Page>
							<RecipePrintTemplate
								{recipe}
								scale={scales[scale]}
								extension={extensions[ext]}
							/>
						</Page>
					{/if}
				{/each}
			{/each}
		{/each}
	{/await}
</PrintPdf>
<!-- <MetricsPanel /> -->

<style>
	.scale-selection {
		display: flex;
		align-items: center;
		flex-wrap: wrap;
	}
	.scale-selection :global(.checkfield) {
		display: flex;
		align-items: center;
		border: 1px solid orange;
		margin: 0.25rem 0.5rem;
		padding-right: 1.25rem;
		cursor: pointer;
	}

	.options-shelf {
		border-bottom: 1px solid #ccc;
		display: flex;
		flex-direction: column;
	}
	@media print {
		.options-shelf {
			display: none !important;
		}
	}
</style>
