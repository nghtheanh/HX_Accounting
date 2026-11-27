import assert from 'node:assert/strict';
import { test } from 'node:test';

test('built web presents the Vietnamese DEMO page', async () => {
  const response = await fetch('http://127.0.0.1:3000', { signal: AbortSignal.timeout(5_000) });
  assert.equal(response.status, 200);
  const html = await response.text();
  assert.match(html, /<html lang="vi">/);
  assert.match(html, /<h1>WorkPilot Accounting<\/h1>/);
  assert.match(html, /Môi trường phát triển · DEMO/);
});

test('built API serves both M0 health endpoints', async () => {
  for (const endpoint of ['health', 'health/ready']) {
    const response = await fetch('http://127.0.0.1:3001/api/v1/' + endpoint, {
      signal: AbortSignal.timeout(5_000),
    });
    assert.equal(response.status, 200);
    assert.equal(response.headers.get('cache-control'), 'no-store');
    assert.deepEqual(await response.json(), { status: 'ok' });
  }
});
