import { createClient } from '@libsql/client';
import * as schema from './schema';
import { env } from '$env/dynamic/private';

const isProduction = env.NODE_ENV === 'production';

let dbInitError = null;
let db = null;

export async function getDb() {
	if (db) return db;
	try {
		if (isProduction) {
			const { drizzle } = await import('drizzle-orm/d1');
			if (!env.DB) throw new Error('D1 binding DB is not available in env');
			db = drizzle(env.DB);
		} else {
			const { drizzle } = await import('drizzle-orm/libsql');
			const databaseUrl = env.DATABASE_URL;
			if (!databaseUrl) throw new Error('DATABASE_URL is not set');
			const client = createClient({ url: databaseUrl });
			db = drizzle(client, { schema });
		}
		return db;
	} catch (err) {
		dbInitError = err;
		throw err;
	}
}

export function getDbInitError() {
	return dbInitError;
}
