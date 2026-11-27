import { createApp } from './create-app.js';

async function bootstrap() {
  const app = await createApp();
  app.enableShutdownHooks();

  await app.listen(Number(process.env.API_PORT ?? '3001'), process.env.API_HOST ?? '127.0.0.1');
}

void bootstrap().catch(() => {
  process.stderr.write('Không thể khởi động API.\n');
  process.exitCode = 1;
});
