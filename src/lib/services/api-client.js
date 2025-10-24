/**
 * API Error Handler Utilities
 * 
 * Provides consistent error handling for API calls
 * Converts API errors to user-friendly messages
 * Supports retry logic with exponential backoff
 * 
 * Usage:
 * import { fetchJson, fetchWithRetry } from '$lib/services/api-client';
 * import { showError } from '$lib/services/toast';
 * 
 * try {
 *   const data = await fetchJson('/api/recipes', { method: 'POST', body });
 *   showSuccess('Recipe saved!');
 * } catch (error) {
 *   showError(formatApiError(error));
 * }
 */

/**
 * Error message mappings for common HTTP status codes and errors
 */
const ERROR_MESSAGES = {
	400: 'Invalid input. Please check your data.',
	401: 'You are not authenticated. Please log in.',
	403: 'You do not have permission to perform this action.',
	404: 'The requested resource was not found.',
	409: 'This resource has been modified by someone else. Please refresh and try again.',
	413: 'The data is too large. Please try with a smaller payload.',
	422: 'Validation failed. Please check your input.',
	429: 'Too many requests. Please wait a moment and try again.',
	500: 'Server error. Please try again later.',
	503: 'The service is temporarily unavailable. Please try again later.',
};

/**
 * Error code to user-friendly message map
 */
const ERROR_CODE_MESSAGES = {
	VALIDATION_ERROR: 'Please check your input and try again.',
	DUPLICATE_ENTRY: 'This item already exists.',
	NOT_FOUND: 'The requested item was not found.',
	FORBIDDEN: 'You do not have permission for this action.',
	NETWORK_ERROR: 'Network connection failed. Please check your internet and try again.',
	TIMEOUT: 'The request took too long. Please try again.',
	UNKNOWN: 'An unexpected error occurred. Please try again.'
};

/**
 * Parse API error response
 * 
 * @param {Response} response - The fetch Response object
 * @returns {Promise<Object>} Parsed error data with code and message
 */
async function parseErrorResponse(response) {
	try {
		const data = await response.json();
		return {
			code: data.code || `HTTP_${response.status}`,
			message: data.error || data.message || ERROR_MESSAGES[response.status] || 'An error occurred',
			fields: data.fields || null,
			status: response.status,
			raw: data
		};
	} catch {
		// Response is not JSON
		return {
			code: `HTTP_${response.status}`,
			message: ERROR_MESSAGES[response.status] || `HTTP Error ${response.status}`,
			status: response.status,
			raw: null
		};
	}
}

/**
 * Format API error for display to user
 * 
 * @param {Error | Object} error - The error object
 * @returns {string} User-friendly error message
 */
export function formatApiError(error) {
	if (typeof error === 'string') {
		return error;
	}

	// Network error
	if (error instanceof TypeError) {
		return ERROR_CODE_MESSAGES.NETWORK_ERROR;
	}

	// Error from parseErrorResponse
	if (error.code && ERROR_CODE_MESSAGES[error.code]) {
		return ERROR_CODE_MESSAGES[error.code];
	}

	// Custom message
	if (error.message) {
		return error.message;
	}

	return ERROR_CODE_MESSAGES.UNKNOWN;
}

/**
 * Format validation error response
 * 
 * @param {Object} error - Error object with fields property
 * @returns {Object} Formatted field errors for display
 */
export function formatValidationError(error) {
	if (!error?.fields) {
		return null;
	}

	const formatted = {};

	Object.entries(error.fields).forEach(([field, messages]) => {
		if (Array.isArray(messages)) {
			formatted[field] = messages.join('; ');
		} else if (typeof messages === 'object' && messages.errors) {
			// Nested errors from arrays
			formatted[field] = formatValidationError(messages);
		} else {
			formatted[field] = String(messages);
		}
	});

	return formatted;
}

/**
 * Fetch with automatic JSON parsing and error handling
 * 
 * @param {string} url - The URL to fetch
 * @param {Object} options - Fetch options
 * @returns {Promise<any>} Parsed response JSON
 * @throws {Object} Error object with code, message, and fields
 */
export async function fetchJson(url, options = {}) {
	const response = await fetch(url, {
		...options,
		headers: {
			'Content-Type': 'application/json',
			...options.headers
		}
	});

	if (!response.ok) {
		const error = await parseErrorResponse(response);
		throw error;
	}

	return response.json();
}

/**
 * Fetch with automatic retry on failure
 * Uses exponential backoff: 1s, 2s, 4s, 8s (default)
 * Does NOT retry on 4xx errors (validation, auth, etc.)
 * 
 * @param {string} url - The URL to fetch
 * @param {Object} options - Fetch options
 * @param {number} maxRetries - Maximum number of retries (default: 3)
 * @param {number} initialDelay - Initial delay in ms (default: 1000)
 * @returns {Promise<any>} Parsed response JSON
 * @throws {Object} Error object with code, message, and fields
 */
export async function fetchWithRetry(url, options = {}, maxRetries = 3, initialDelay = 1000) {
	let lastError;
	let delay = initialDelay;

	for (let attempt = 0; attempt <= maxRetries; attempt++) {
		try {
			return await fetchJson(url, options);
		} catch (error) {
			lastError = error;

			// Don't retry on 4xx errors (client errors)
			if (error.status >= 400 && error.status < 500) {
				throw error;
			}

			// Don't retry on last attempt
			if (attempt === maxRetries) {
				throw error;
			}

			// Wait before retrying
			console.warn(`Retry attempt ${attempt + 1}/${maxRetries} after ${delay}ms`, error);
			await new Promise((resolve) => setTimeout(resolve, delay));
			delay *= 2; // Exponential backoff
		}
	}

	throw lastError;
}

/**
 * Wrap an async function with error handling
 * Useful for event handlers and callbacks
 * 
 * @param {Function} fn - Async function to wrap
 * @param {Function} onError - Error callback (optional)
 * @param {Function} onSuccess - Success callback (optional)
 * @returns {Function} Wrapped function
 */
export function withErrorHandler(fn, onError, onSuccess) {
	return async function (...args) {
		try {
			const result = await fn(...args);
			if (onSuccess) {
				onSuccess(result);
			}
			return result;
		} catch (error) {
			const formatted = formatApiError(error);
			if (onError) {
				onError(error, formatted);
			}
			throw error;
		}
	};
}

export default {
	parseErrorResponse,
	formatApiError,
	formatValidationError,
	fetchJson,
	fetchWithRetry,
	withErrorHandler
};
