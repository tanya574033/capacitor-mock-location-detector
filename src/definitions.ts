export interface CapacitorMockLocationDetectorPlugin {
  detectMockLocation(): Promise<{ isMockLocation: boolean, message: string }>;
}
