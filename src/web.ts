import { WebPlugin } from '@capacitor/core';

import type { CapacitorMockLocationDetectorPlugin } from './definitions';

export class CapacitorMockLocationDetectorWeb
  extends WebPlugin
  implements CapacitorMockLocationDetectorPlugin {

  async detectMockLocation(): Promise<{ isMockLocation: boolean; message: string }> {
    return {
      isMockLocation: false,
      message: 'Does not support detecting mock locations on the web platform.'
    };
  }
}
