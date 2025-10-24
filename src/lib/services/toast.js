/**
 * Toast Notification System
 * 
 * Provides a simple, composable toast notification service
 * Handles success, error, warning, and info messages
 * 
 * Usage:
 * import { showToast } from '$lib/services/toast';
 * 
 * showToast('Success!', 'success');
 * showToast('Error occurred', 'error', 5000); // 5 second timeout
 * showToast('Warning', 'warning');
 * showToast('Info', 'info');
 */

import { writable } from 'svelte/store';

/**
 * Toast types
 * @type {('success' | 'error' | 'warning' | 'info')}
 */
const TOAST_TYPES = {
	SUCCESS: 'success',
	ERROR: 'error',
	WARNING: 'warning',
	INFO: 'info'
};

/**
 * Default timeout per toast type (in milliseconds)
 */
const DEFAULT_TIMEOUTS = {
	success: 3000,
	error: 5000,
	warning: 4000,
	info: 3000
};

/**
 * Unique ID counter for toasts
 */
let toastId = 0;

/**
 * Store of active toasts
 * @type {import('svelte/store').Writable<Array>}
 */
export const toasts = writable([]);

/**
 * Show a toast notification
 * 
 * @param {string} message - The message to display
 * @param {string} type - Type of toast: 'success', 'error', 'warning', 'info'
 * @param {number} timeout - How long to show the toast (ms). Set to 0 for no auto-dismiss
 * @returns {number} Toast ID for programmatic dismissal
 */
export function showToast(message, type = 'info', timeout = null) {
	const id = toastId++;
	const finalTimeout = timeout ?? DEFAULT_TIMEOUTS[type] ?? 3000;

	const toast = {
		id,
		message,
		type,
		timestamp: new Date().toISOString()
	};

	// Add toast to store
	toasts.update((current) => [...current, toast]);

	// Auto-dismiss after timeout (if timeout > 0)
	if (finalTimeout > 0) {
		setTimeout(() => {
			dismissToast(id);
		}, finalTimeout);
	}

	return id;
}

/**
 * Dismiss a specific toast by ID
 * 
 * @param {number} id - The toast ID to dismiss
 */
export function dismissToast(id) {
	toasts.update((current) => current.filter((t) => t.id !== id));
}

/**
 * Clear all active toasts
 */
export function clearToasts() {
	toasts.set([]);
}

/**
 * Show success toast
 * 
 * @param {string} message - The message to display
 * @param {number} timeout - Optional custom timeout (ms)
 * @returns {number} Toast ID
 */
export function showSuccess(message, timeout) {
	return showToast(message, TOAST_TYPES.SUCCESS, timeout);
}

/**
 * Show error toast
 * 
 * @param {string} message - The message to display
 * @param {number} timeout - Optional custom timeout (ms)
 * @returns {number} Toast ID
 */
export function showError(message, timeout) {
	return showToast(message, TOAST_TYPES.ERROR, timeout);
}

/**
 * Show warning toast
 * 
 * @param {string} message - The message to display
 * @param {number} timeout - Optional custom timeout (ms)
 * @returns {number} Toast ID
 */
export function showWarning(message, timeout) {
	return showToast(message, TOAST_TYPES.WARNING, timeout);
}

/**
 * Show info toast
 * 
 * @param {string} message - The message to display
 * @param {number} timeout - Optional custom timeout (ms)
 * @returns {number} Toast ID
 */
export function showInfo(message, timeout) {
	return showToast(message, TOAST_TYPES.INFO, timeout);
}

/**
 * Handle API error and show appropriate toast
 * 
 * @param {Error} error - The error object
 * @param {string} defaultMessage - Fallback message if error has no message
 * @returns {number} Toast ID
 */
export function showErrorFromResponse(error, defaultMessage = 'An error occurred') {
	let message = defaultMessage;

	// Extract message from various error formats
	if (error?.response?.data?.error) {
		message = error.response.data.error;
	} else if (error?.message) {
		message = error.message;
	} else if (typeof error === 'string') {
		message = error;
	}

	return showError(message);
}

export default {
	showToast,
	dismissToast,
	clearToasts,
	showSuccess,
	showError,
	showWarning,
	showInfo,
	showErrorFromResponse,
	toasts
};
