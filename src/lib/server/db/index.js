import { drizzle } from 'drizzle-orm/libsql';
import { createClient } from '@libsql/client';
import * as schema from './schema';
import { env } from '$env/dynamic/private';
const isProduction = env.NODE_ENV === 'production';
const databaseUrl = isProduction ? env.DB : env.DATABASE_URL;
if (!databaseUrl) throw new Error('Database URL is not set');
// if (!env.DATABASE_URL) throw new Error('DATABASE_URL is not set');

const client = createClient({ url: env.DATABASE_URL });

export const db = drizzle(client, { schema });
