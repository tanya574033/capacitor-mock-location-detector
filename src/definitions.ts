export interface CapacitorMockLocationDetectorPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
