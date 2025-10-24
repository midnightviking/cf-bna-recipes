<script>
	/**
	 * Error Boundary Component
	 * 
	 * Catches errors from child components and displays fallback UI
	 * Prevents entire app from crashing due to component errors
	 * 
	 * Usage:
	 * <ErrorBoundary>
	 *   {@render children()}
	 * </ErrorBoundary>
	 */

	let { children } = $props();

	let error = $state(null);
	let errorInfo = $state(null);

	/**
	 * Captures errors from child components
	 */
	function handleError(err) {
		error = err;
		errorInfo = {
			timestamp: new Date().toISOString(),
			message: err?.message || 'Unknown error occurred',
			stack: err?.stack
		};
		console.error('Error caught by boundary:', errorInfo);
	}

	/**
	 * Resets error state to allow retry
	 */
	function resetError() {
		error = null;
		errorInfo = null;
	}
</script>

<svelte:window on:error={(e) => handleError(e.error)} />

<div>
	{#if error}
		<div class="error-boundary">
			<div class="error-content">
				<div class="error-header">
					<h2>⚠️ Something went wrong</h2>
					<p class="error-message">{errorInfo.message}</p>
				</div>

				{#if errorInfo.stack && import.meta.env.DEV}
					<details class="error-stack">
						<summary>Stack trace (Dev mode)</summary>
						<pre>{errorInfo.stack}</pre>
					</details>
				{/if}

				<div class="error-actions">
					<button class="retry-button" onclick={resetError}>
						Try Again
					</button>
					<button class="home-button" onclick={() => window.location.href = '/'}>
						Go Home
					</button>
				</div>

				<p class="error-timestamp">Error at {errorInfo.timestamp}</p>
			</div>
		</div>
	{:else}
		{@render children()}
	{/if}
</div>

<style>
	.error-boundary {
		display: flex;
		align-items: center;
		justify-content: center;
		min-height: 400px;
		padding: 2rem;
		background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
	}

	.error-content {
		background: white;
		border-radius: 8px;
		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
		padding: 2rem;
		max-width: 500px;
		width: 100%;
	}

	.error-header {
		margin-bottom: 1.5rem;
		border-bottom: 2px solid #ef4444;
		padding-bottom: 1rem;
	}

	.error-header h2 {
		margin: 0 0 0.5rem 0;
		color: #dc2626;
		font-size: 1.5rem;
	}

	.error-message {
		margin: 0;
		color: #666;
		font-size: 1rem;
		line-height: 1.5;
	}

	.error-stack {
		margin: 1rem 0;
		padding: 1rem;
		background: #f3f4f6;
		border-left: 3px solid #9ca3af;
		border-radius: 4px;
		cursor: pointer;
	}

	.error-stack summary {
		color: #6b7280;
		font-size: 0.875rem;
		font-weight: 500;
		user-select: none;
	}

	.error-stack summary:hover {
		color: #374151;
	}

	.error-stack pre {
		margin: 0.5rem 0 0 0;
		font-size: 0.75rem;
		overflow-x: auto;
		color: #374151;
		white-space: pre-wrap;
		word-wrap: break-word;
	}

	.error-actions {
		display: flex;
		gap: 1rem;
		margin: 1.5rem 0;
	}

	.retry-button,
	.home-button {
		flex: 1;
		padding: 0.75rem 1rem;
		border: none;
		border-radius: 6px;
		font-weight: 600;
		cursor: pointer;
		transition: all 0.2s ease;
		font-size: 1rem;
	}

	.retry-button {
		background: #3b82f6;
		color: white;
	}

	.retry-button:hover {
		background: #2563eb;
		transform: translateY(-2px);
		box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4);
	}

	.retry-button:active {
		transform: translateY(0);
	}

	.home-button {
		background: #e5e7eb;
		color: #374151;
	}

	.home-button:hover {
		background: #d1d5db;
		transform: translateY(-2px);
	}

	.home-button:active {
		transform: translateY(0);
	}

	.error-timestamp {
		margin: 0;
		font-size: 0.75rem;
		color: #9ca3af;
		text-align: center;
	}

	@media (max-width: 640px) {
		.error-boundary {
			min-height: 300px;
			padding: 1rem;
		}

		.error-content {
			padding: 1.5rem;
		}

		.error-actions {
			flex-direction: column;
		}

		.retry-button,
		.home-button {
			width: 100%;
		}
	}
</style>
