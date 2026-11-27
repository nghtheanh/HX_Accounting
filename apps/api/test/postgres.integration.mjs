import assert from 'node:assert/strict';
import { test } from 'node:test';
import { Client } from 'pg';
import { createApp } from '../dist/create-app.js';

test('DEMO PostgreSQL 17 has the bootstrap migration and serves API readiness', async () => {
  assert.ok(process.env.DATABASE_URL, 'DATABASE_URL must point to an isolated DEMO database');
  const client = new Client({
    connectionString: process.env.DATABASE_URL,
    connectionTimeoutMillis: 2_000,
    query_timeout: 2_000,
  });
  await client.connect();
  try {
    const state = await client.query(`
      SELECT current_database() AS database,
             current_setting('server_version_num')::integer / 10000 AS major,
             to_regnamespace('workpilot') IS NOT NULL AS schema_exists,
             count(*)::integer AS applied
      FROM public._prisma_migrations
      WHERE migration_name = '20261127000000_bootstrap'
        AND finished_at IS NOT NULL AND rolled_back_at IS NULL
    `);
    assert.deepEqual(state.rows, [
      { database: 'workpilot_demo', major: 17, schema_exists: true, applied: 1 },
    ]);
  } finally {
    await client.end();
  }

  const app = await createApp({ logger: false });
  try {
    await app.listen(0, '127.0.0.1');
    const response = await fetch((await app.getUrl()) + '/api/v1/health/ready');
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { status: 'ok' });
  } finally {
    await app.close();
  }
});
