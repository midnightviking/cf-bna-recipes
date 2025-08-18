import { env } from '$env/dynamic/private';
import { recordRequestMetric } from '$lib/server/metrics.js';

// Basic per-request metrics: total time and query counts (via console logs)
export async function handle({ event, resolve }) {
  const start = performance.now();
  // Simple in-memory counters per request
  let queryCount = 0;
  let totalQueryMs = 0;

  // Allow downstream code to increment counters
  event.locals.__metrics = {
    incQuery: (ms) => { queryCount++; totalQueryMs += ms || 0; },
    get: () => ({ queryCount, totalQueryMs })
  };

  const response = await resolve(event);

  if (env.METRICS_LOG === '1' || env.DB_LOG === '1' || env.NODE_ENV === 'development') {
    const durMs = performance.now() - start;
    const { queryCount: qc = 0, totalQueryMs: tq = 0 } = event.locals?.__metrics?.get?.() ?? {};
    /* console.log(
      `[metrics] ${event.request.method} ${new URL(event.request.url).pathname} -> ${response.status} in ${durMs.toFixed(1)}ms (queries: ${qc}, query time ~${(typeof tq === 'number' ? tq.toFixed(1) : String(tq))}ms)`
    ); */
    // store recent entry for viewing in UI
    try {
      recordRequestMetric({
        method: event.request.method,
        path: new URL(event.request.url).pathname,
        status: response.status,
        durationMs: Math.round(durMs),
        queryCount: qc,
        totalQueryMs: Number(tq || 0)
      });
    } catch {}
  }

  return response;
}
