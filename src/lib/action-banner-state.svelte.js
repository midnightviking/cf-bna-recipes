import { onDestroy } from 'svelte';
import { writable, get } from 'svelte/store';

// Writable store for banner actions (array of { label, func, icon? })
export const bannerActions = writable([]);

export function setBannerActions(actions = []) {
  bannerActions.set(Array.isArray(actions) ? actions : []);
}

export function addBannerAction(action) {
  if (!action) return;
  bannerActions.update(list => [...list, action]);
}

export function clearBannerActions() {
  bannerActions.set([]);
}

// Hook for pages: sets actions and clears them on unmount if unchanged
export function useBannerActions(actions = []) {
  setBannerActions(actions);
  const ref = actions; // reference for comparison
  onDestroy(() => {
    const current = get(bannerActions);
    if (current === ref || (current.length === ref.length && current.every((a,i)=>a===ref[i]))) {
      clearBannerActions();
    }
  });
}
