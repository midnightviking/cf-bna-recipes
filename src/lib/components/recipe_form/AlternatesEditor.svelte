<script>
  // Props: alternates (writable)
  let {alternates=[]} = $props();

  function onAlternateChange(ai, val) {
    alternates[ai].alternate_ingredient = val;
    alternates = [...alternates];
  }
  function onRemoveAlternate(ai) {
    alternates.splice(ai, 1);
    alternates = [...alternates];
  }
  function onAddAlternate() {
    alternates = [
      ...alternates,
      { original_ingredient: '', alternate_ingredient: '' },
    ];
  }
</script>

<div class="alternates-editor">
  <strong>Alternates</strong>
  <ul>
    {#each alternates as alt, ai}
      <li>
        <input
          type="text"
          bind:value={alt.alternate_ingredient}
          placeholder="Alternate name"
          oninput={e => onAlternateChange(ai, e.target.value)}
        />
        <button type="button" onclick={() => onRemoveAlternate(ai)}>Remove</button>
      </li>
    {/each}
  </ul>
  <button type="button" onclick={onAddAlternate}>Add Alternate</button>
</div>
