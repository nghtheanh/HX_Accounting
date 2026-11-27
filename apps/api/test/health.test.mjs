import assert from 'node:assert/strict';
import { test } from 'node:test';
import { createApp } from '../dist/create-app.js';

test('liveness stays up when database configuration is missing', async () => {
  const originalUrl = process.env.DATABASE_URL;
  delete process.env.DATABASE_URL;
  const app = await createApp({ logger: false });
  try {
    await app.listen(0, '127.0.0.1');
    const address = await app.getUrl();

    const live = await fetch(address + '/api/v1/health');
    assert.equal(live.status, 200);
    assert.equal(live.headers.get('cache-control'), 'no-store');
    assert.deepEqual(await live.json(), { status: 'ok' });

    const ready = await fetch(address + '/api/v1/health/ready');
    assert.equal(ready.status, 503);
    assert.deepEqual(await ready.json(), { status: 'unavailable' });
  } finally {
    await app.close();
    if (originalUrl !== undefined) process.env.DATABASE_URL = originalUrl;
  }
});
