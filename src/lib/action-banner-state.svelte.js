import { getContext, setContext } from 'svelte';

/**
 * Manages a collection of action banner items.
 *
 * Each action is an object with the following structure:
 * {
 *   label: {string} - The display label for the action.
 *   icon: {string} - The icon identifier for the action.
 *   func: {Function} - The function to execute when the action is triggered.
 * }
 */
export class ActionBannerState {
	actions = $state([]);
	
	constructor(){
		this.actions = [];
	}

	getActions() {
		return this.actions;
	}

	addAction(label, icon, func) {
		this.actions.push({ label: label, icon: icon, func: func });
	}

	
	setActions(actions=[]) {
		
		this.actions = actions;
	}
}

const ACTIONBANNER = 'ActionBanner';
export function setActionBannerState() {

	return setContext(ACTIONBANNER, new ActionBannerState());
}
export function getActionBannerState() {
	return getContext(ACTIONBANNER);
}