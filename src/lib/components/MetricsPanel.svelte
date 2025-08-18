<script>
  import { onMount } from 'svelte';
  import { dev } from '$app/environment';

  let open = $state(true);
  let enabled = $state(dev);
  let recent = $state([]);
  let timer = null;

  async function load() {
    try {
      const res = await fetch('/api/metrics', { cache: 'no-store' });
      if (!res.ok) { enabled = false; return; }
      const data = await res.json();
      recent = (data?.recent ?? []).slice(-50);
    } catch (e) {
      enabled = false;
    }
  }

  onMount(() => {
    if (!enabled) return;
    load();
    timer = setInterval(load, 5000);
    return () => { if (timer) clearInterval(timer); };
  });
</script>

{#if enabled}
  <div class={`metrics-panel ${open ? '' : 'collapsed'}`}>
  <button class="toggle" onclick={() => open = !open} aria-label="Toggle metrics panel">
      {open ? '▼' : '▲'}
    </button>
    {#if open}
      <div class="body">
        <div class="header">
          <strong>Recent Requests</strong>
        </div>
        <div class="list">
          {#each [...recent].slice().reverse().slice(0, 20) as m}
            <div class="row">
              <span class="meth">{m.method}</span>
              <span class="path" title={m.path}>{m.path}</span>
              <span class="status {m.status >= 500 ? 'err' : (m.status >= 400 ? 'warn' : 'ok')}">{m.status}</span>
              <span class="dur">{m.durationMs?.toFixed ? m.durationMs.toFixed(0) : m.durationMs}ms</span>
              <span class="q">q:{m.queryCount}</span>
              <span class="qt">qt:{m.totalQueryMs?.toFixed ? m.totalQueryMs.toFixed(0) : m.totalQueryMs}ms</span>
            </div>
          {/each}
          {#if recent.length === 0}
            <div class="empty">No recent metrics</div>
          {/if}
        </div>
      </div>
    {/if}
  </div>
{/if}

<style>
  .metrics-panel {
    position: fixed;
    right: 12px;
    bottom: 12px;
    z-index: 9999;
    font: 12px/1.3 system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
    color: #222;
  }
  .metrics-panel .toggle {
    position: absolute;
    right: 0;
    bottom: 100%;
    margin-bottom: 2px;
    border: 1px solid #ccc;
    background: #fff;
    color: #333;
    border-radius: 4px;
    padding: 2px 6px;
    cursor: pointer;
  }
  .metrics-panel .body {
    width: 540px;
    max-height: 240px;
    overflow: auto;
    background: rgba(255,255,255,0.95);
    border: 1px solid #ddd;
    border-radius: 6px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.15);
    backdrop-filter: blur(4px);
  }
  .metrics-panel .header {
    position: sticky;
    top: 0;
    background: #f8f8f8;
    border-bottom: 1px solid #e5e5e5;
    padding: 6px 8px;
  }
  .metrics-panel .list { padding: 4px; }
  .metrics-panel .row {
    display: grid;
    grid-template-columns: 48px 1fr 48px 56px 40px 64px;
    gap: 6px;
    align-items: center;
    padding: 4px 6px;
    border-bottom: 1px dashed #eee;
    white-space: nowrap;
  }
  .metrics-panel .row:last-child { border-bottom: none; }
  .metrics-panel .meth { font-weight: 600; }
  .metrics-panel .path { overflow: hidden; text-overflow: ellipsis; }
  .metrics-panel .status.ok { color: #137333; }
  .metrics-panel .status.warn { color: #b06000; }
  .metrics-panel .status.err { color: #b00020; font-weight: 600; }
  .metrics-panel .empty { padding: 8px; color: #666; text-align: center; }
</style>
