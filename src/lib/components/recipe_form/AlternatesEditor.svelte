<script>
	import { recipeStore } from '$lib/stores/recipeStore.js';
	import { showError } from '$lib/services/toast.js';

	// Destructure stores
	const { alternates } = recipeStore;

	function onAlternateChange(alternateId, val) {
		try {
			recipeStore.updateAlternate(alternateId, { alternate_ingredient: val });
		} catch (error) {
			showError(error.message);
		}
	}

	function onRemoveAlternate(alternateId) {
		try {
			recipeStore.deleteAlternate(alternateId);
		} catch (error) {
			showError(error.message);
		}
	}

	function onAddAlternate() {
		try {
			recipeStore.addAlternate({
				original_ingredient: '',
				alternate_ingredient: '',
			});
		} catch (error) {
			showError(error.message);
		}
	}
</script>

<div class="alternates-editor">
  <strong>Alternates</strong>
  <ul>
    {#each $alternates as alt}
      <li>
        <input
          type="text"
          value={alt.alternate_ingredient}
          placeholder="Alternate name"
          oninput={(e) => onAlternateChange(alt.id, e.target.value)}
        />
        <button type="button" onclick={() => onRemoveAlternate(alt.id)}>Remove</button>
      </li>
    {/each}
  </ul>
  <button type="button" onclick={onAddAlternate}>Add Alternate</button>
</div>
