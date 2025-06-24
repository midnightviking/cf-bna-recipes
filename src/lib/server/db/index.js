import { createClient } from '@libsql/client';
import * as schema from './schema';
import { env } from '$env/dynamic/private';

const isProduction = env.NODE_ENV === 'production';

let db;

if (isProduction) {
	// Use drizzle-orm/d1 for D1 in production
	const { drizzle } = await import('drizzle-orm/d1');
	db = drizzle(env.context.DB, { schema }); // D1 bindings are injected at runtime (Cloudflare Workers)
} else {
	// Use drizzle-orm/libsql for local development
	const { drizzle } = await import('drizzle-orm/libsql');
	const databaseUrl = env.DATABASE_URL;
	if (!databaseUrl) throw new Error('DATABASE_URL is not set');
	const client = createClient({ url: databaseUrl });
	db = drizzle(client, { schema });
}

export { db };
