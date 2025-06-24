import { createClient } from '@libsql/client';
import * as schema from './schema';
import { env } from '$env/dynamic/private';

let dbInitError = null;
let db = null;

export async function getDb() {
	if (db) return db;
	try {
		if (env.DB) {
			const { drizzle } = await import('drizzle-orm/d1');
			db = drizzle(env.DB);
		} else if (env.DATABASE_URL) {
			const { drizzle } = await import('drizzle-orm/libsql');
			const client = createClient({ url: env.DATABASE_URL });
			db = drizzle(client, { schema });
		} else {
			throw new Error('No D1 binding (env.DB) or DATABASE_URL found in environment');
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
