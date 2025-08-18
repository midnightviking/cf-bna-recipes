import { createClient } from '@libsql/client';
import * as schema from './schema';
import { env } from '$env/dynamic/private';

let dbInitError = null;
let db = null;

export async function getDb() {
	if (db) return db;
	try {
		const enableLog = (env.DB_LOG === '1' || env.DB_LOG === 'true' || env.LOG_QUERIES === '1' || env.NODE_ENV === 'development');
		if (env.DB) {
			const { drizzle } = await import('drizzle-orm/d1');
			db = drizzle(env.DB, { schema, logger: enableLog });
		} else if (env.DATABASE_URL) {
			const { drizzle } = await import('drizzle-orm/libsql');
			const client = createClient({ url: env.DATABASE_URL });
			db = drizzle(client, { schema, logger: enableLog });
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
