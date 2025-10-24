
<script>
  import { onMount } from 'svelte';
  import Sortable from 'sortablejs';
	import { recipeStore } from '$lib/stores/recipeStore.js';
	import { showError } from '$lib/services/toast.js';
	import Button from '@smui/button';
	import Textfield from '@smui/textfield';

	// Destructure stores
	const { sections } = recipeStore;
	let new_section_name = $state('');
	let sectionRowsContainer;

	function onSectionNameChange(sectionId, val) {
		try {
			recipeStore.updateSection(sectionId, { name: val });
		} catch (error) {
			showError(error.message);
		}
	}

	function onRemoveSection(sectionId) {
		try {
			recipeStore.deleteSection(sectionId);
		} catch (error) {
			showError(error.message);
		}
	}

	function onAddSection() {
		if ((new_section_name || '').trim()) {
			try {
				recipeStore.addSection({
					name: new_section_name.trim(),
				});
				new_section_name = '';
			} catch (error) {
				showError(error.message);
			}
		}
	}

	onMount(() => {
		// Only enable sorting if there are at least 2 sections
		if (sectionRowsContainer && sectionRowsContainer.children.length > 1) {
			Sortable.create(sectionRowsContainer, {
				animation: 200,
				handle: '.section-row',
				onEnd: (evt) => {
					// Reorder sections based on new DOM order
					try {
						const newOrder = Array.from(sectionRowsContainer.children)
							.map(row => row.getAttribute('data-section-id'))
							.map(id => parseInt(id));
						
						// Update ordering for each section
						newOrder.forEach((sectionId, index) => {
							recipeStore.updateSection(sectionId, { ordering: index });
						});
					} catch (error) {
						showError(error.message);
					}
				}
			});
		}
	});
</script>

<div class="recipe-sections">
  <strong>Sections</strong>
  <div class="sections-list" bind:this={sectionRowsContainer}>
    {#each $sections as s}
      <div class="section-row" data-section-id={s.id}>
        <input
          type="text"
          value={s.name}
          placeholder="Section name"
          oninput={(e) => onSectionNameChange(s.id, e.target.value)}
        />
        <button type="button" title="Remove" onclick={() => onRemoveSection(s.id)}>Remove</button>
      </div>
    {/each}
  </div>
  <div class="add-section">
    <Textfield
      type="text"
      bind:value={new_section_name}
      label="New section name"
    />
    <Button type="button" onclick={onAddSection}>Add Section</Button>
  </div>
</div>
