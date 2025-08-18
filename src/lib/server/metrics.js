// Simple in-memory ring buffer of recent request metrics
const MAX = 200;
/** @type {Array<{id:number, ts:number, method:string, path:string, status:number, durationMs:number, queryCount:number, totalQueryMs:number}>} */
const buffer = [];
let nextId = 1;

export function recordRequestMetric(m) {
  const id = nextId++;
  if(m.path == '/api/metrics') {
   
   return;
  }
  const entry = {
    id,
    ts: Date.now(),
    method: m.method,
    path: m.path,
    status: m.status,
    durationMs: m.durationMs,
    queryCount: m.queryCount || 0,
    totalQueryMs: m.totalQueryMs || 0,
  };
  buffer.push(entry);
  if (buffer.length > MAX) buffer.shift();
  return entry;
}

export function getRecentMetrics() {
  // newest last; client can reverse if desired
  return buffer.slice(-MAX);
}
