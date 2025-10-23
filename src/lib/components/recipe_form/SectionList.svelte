
<script>
  import { onMount } from 'svelte';
  import Sortable from 'sortablejs';
	import Button from '@smui/button';
	import Textfield from '@smui/textfield';
  export let section_list;
  export let new_section_name;

  function onSectionNameChange(si, val) {
    section_list[si].name = val;
    section_list = [...section_list];
  }
  function onRemoveSection(si) {
    section_list.splice(si, 1);
    section_list = [...section_list];
  }
  function onAddSection() {
    if ((new_section_name || '').trim()) {
      // Generate a temporary negative ID for new sections
      // Use timestamp to ensure uniqueness
      const tempId = -1 * (Date.now() % 1000000);
      section_list = [
        ...section_list,
        { 
          id: tempId,
          name: new_section_name.trim(), 
          ordering: section_list.length 
        },
      ];
      new_section_name = '';
    }
  }

  let sectionRows = [];

  onMount(() => {
    // Only enable sorting if there are at least 2 sections
    if (sectionRows.length > 1) {
      Sortable.create(sectionRowsContainer, {
        animation: 200,
        handle: '.section-row',
        onEnd: (evt) => {
          // Reorder section_list based on new DOM order
          const newOrder = Array.from(sectionRowsContainer.children)
            .map(row => row.getAttribute('data-section-index'))
            .map(idx => parseInt(idx));
          section_list = newOrder.map(i => section_list[i]);
        }
      });
    }
  });
  let sectionRowsContainer;
</script>

<div class="recipe-sections">
  <strong>Sections</strong>
  <div class="sections-list" bind:this={sectionRowsContainer}>
    {#each section_list as s, si}
      {#if s.id > 0}
        <div class="section-row" data-section-index={si} bind:this={sectionRows[si]}>
          <input
            type="text"
            bind:value={section_list[si].name}
            placeholder="Section name"
            oninput={e => onSectionNameChange(si, e.target.value)}
          />
          <button type="button" title="Remove" onclick={() => onRemoveSection(si)}>Remove</button>
        </div>
      {/if}
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
