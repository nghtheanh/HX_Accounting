import { Injectable, type OnModuleDestroy } from '@nestjs/common';
import { Pool } from 'pg';

@Injectable()
export class DatabaseProbe implements OnModuleDestroy {
  private readonly pool = process.env.DATABASE_URL
    ? new Pool({
        connectionString: process.env.DATABASE_URL,
        max: 2,
        connectionTimeoutMillis: 1_000,
        query_timeout: 1_000,
      })
    : undefined;

  constructor() {
    this.pool?.on('error', () => {
      // pg removes the failed idle connection. A later probe can reconnect.
      process.stderr.write('PostgreSQL idle connection failed.\n');
    });
  }

  async check(): Promise<boolean> {
    if (!this.pool) return false;

    try {
      await this.pool.query('SELECT 1');
      return true;
    } catch {
      return false;
    }
  }

  async onModuleDestroy(): Promise<void> {
    await this.pool?.end();
  }
}
