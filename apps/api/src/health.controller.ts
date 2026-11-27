import { Controller, Get, Header, ServiceUnavailableException } from '@nestjs/common';
import { DatabaseProbe } from './database-probe.js';

@Controller('health')
export class HealthController {
  constructor(private readonly database: DatabaseProbe) {}

  @Get()
  @Header('Cache-Control', 'no-store')
  live() {
    return { status: 'ok' };
  }

  @Get('ready')
  @Header('Cache-Control', 'no-store')
  async ready() {
    if (!(await this.database.check())) {
      throw new ServiceUnavailableException({ status: 'unavailable' });
    }

    return { status: 'ok' };
  }
}
