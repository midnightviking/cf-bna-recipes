<script>
	/**
	 * Toast Display Component
	 * 
	 * Renders toast notifications from the toast store
	 * Place this component once in your root layout
	 * 
	 * Usage in +layout.svelte:
	 * <ToastDisplay />
	 */

	import { toasts, dismissToast } from '$lib/services/toast.js';

	// Re-export for animations if needed
	const ANIMATION_DURATION = 300;
</script>

<div class="toast-container">
	{#each $toasts as toast (toast.id)}
		<div
			class="toast toast--{toast.type}"
			role="alert"
			aria-live="polite"
			aria-atomic="true"
			in:slideIn={{ duration: ANIMATION_DURATION }}
			out:slideOut={{ duration: ANIMATION_DURATION }}
		>
			<div class="toast-icon">
				{#if toast.type === 'success'}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<polyline points="20 6 9 17 4 12"></polyline>
					</svg>
				{:else if toast.type === 'error'}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<circle cx="12" cy="12" r="10"></circle>
						<line x1="15" y1="9" x2="9" y2="15"></line>
						<line x1="9" y1="9" x2="15" y2="15"></line>
					</svg>
				{:else if toast.type === 'warning'}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3.05h16.94a2 2 0 0 0 1.71-3.05L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
						<line x1="12" y1="9" x2="12" y2="13"></line>
						<line x1="12" y1="17" x2="12.01" y2="17"></line>
					</svg>
				{:else}
					<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<circle cx="12" cy="12" r="10"></circle>
						<line x1="12" y1="16" x2="12" y2="12"></line>
						<line x1="12" y1="8" x2="12.01" y2="8"></line>
					</svg>
				{/if}
			</div>

			<div class="toast-content">
				<p class="toast-message">{toast.message}</p>
			</div>

			<button
				class="toast-close"
				onclick={() => dismissToast(toast.id)}
				aria-label="Close notification"
				title="Close"
			>
				<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
					<line x1="18" y1="6" x2="6" y2="18"></line>
					<line x1="6" y1="6" x2="18" y2="18"></line>
				</svg>
			</button>
		</div>
	{/each}
</div>

<style>
	.toast-container {
		position: fixed;
		top: 1rem;
		right: 1rem;
		z-index: 9999;
		display: flex;
		flex-direction: column;
		gap: 0.75rem;
		pointer-events: none;
	}

	.toast {
		display: flex;
		align-items: flex-start;
		gap: 1rem;
		padding: 1rem;
		background: white;
		border-radius: 6px;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
		min-width: 300px;
		max-width: 500px;
		pointer-events: auto;
		animation: slideInRight 0.3s ease-out;
	}

	.toast--success {
		border-left: 4px solid #10b981;
	}

	.toast--success .toast-icon {
		color: #10b981;
	}

	.toast--error {
		border-left: 4px solid #ef4444;
	}

	.toast--error .toast-icon {
		color: #ef4444;
	}

	.toast--warning {
		border-left: 4px solid #f59e0b;
	}

	.toast--warning .toast-icon {
		color: #f59e0b;
	}

	.toast--info {
		border-left: 4px solid #3b82f6;
	}

	.toast--info .toast-icon {
		color: #3b82f6;
	}

	.toast-icon {
		flex-shrink: 0;
		width: 24px;
		height: 24px;
		margin-top: 0.125rem;
	}

	.toast-icon svg {
		width: 100%;
		height: 100%;
	}

	.toast-content {
		flex: 1;
		display: flex;
		flex-direction: column;
		gap: 0.25rem;
	}

	.toast-message {
		margin: 0;
		font-size: 0.95rem;
		line-height: 1.4;
		color: #1f2937;
	}

	.toast-close {
		flex-shrink: 0;
		width: 24px;
		height: 24px;
		padding: 0;
		background: none;
		border: none;
		color: #9ca3af;
		cursor: pointer;
		display: flex;
		align-items: center;
		justify-content: center;
		border-radius: 4px;
		transition: all 0.2s ease;
		margin-top: 0.125rem;
	}

	.toast-close:hover {
		color: #374151;
		background: #f3f4f6;
	}

	.toast-close:active {
		background: #e5e7eb;
	}

	.toast-close svg {
		width: 100%;
		height: 100%;
	}

	@keyframes slideInRight {
		from {
			opacity: 0;
			transform: translateX(100%);
		}

		to {
			opacity: 1;
			transform: translateX(0);
		}
	}

	@media (max-width: 640px) {
		.toast-container {
			left: 1rem;
			right: 1rem;
			top: auto;
			bottom: 1rem;
		}

		.toast {
			min-width: unset;
			max-width: unset;
		}
	}
</style>

<script context="module">
	/**
	 * Transition for toast slide in
	 */
	export function slideIn(node, { duration = 300 }) {
		return {
			duration,
			css: (t) => {
				const easeOut = 1 - Math.pow(1 - t, 3);
				return `
					opacity: ${easeOut};
					transform: translateX(${(1 - easeOut) * 100}%);
				`;
			}
		};
	}

	/**
	 * Transition for toast slide out
	 */
	export function slideOut(node, { duration = 300 }) {
		return {
			duration,
			css: (t) => {
				const easeIn = Math.pow(t, 3);
				return `
					opacity: ${1 - easeIn};
					transform: translateX(${easeIn * 100}%);
				`;
			}
		};
	}
</script>
