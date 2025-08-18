import { getRecentMetrics } from '$lib/server/metrics.js';
import { env } from '$env/dynamic/private';

export async function GET() {
  if (!(env.METRICS_API === '1' || env.NODE_ENV === 'development')) {
    return new Response('Disabled', { status: 404 });
  }
  return new Response(JSON.stringify({ recent: getRecentMetrics() }), {
    headers: { 'Content-Type': 'application/json' }
  });
}
