import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
@Injectable()
export class AppService {
  getHello(): string {
    const configService = new ConfigService();
    console.log(configService.get('RDS_HOSTNAME'), '-IS MY VAL');
    return 'Hello World!';
  }
}
