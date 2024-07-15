import { WebPlugin } from '@capacitor/core';

import type { CapacitorMockLocationDetectorPlugin } from './definitions';

export class CapacitorMockLocationDetectorWeb
  extends WebPlugin
  implements CapacitorMockLocationDetectorPlugin
{
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
