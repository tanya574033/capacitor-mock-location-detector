import { CapacitorMockLocationDetector } from 'capacitor-mock-location-detector-plugin';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    CapacitorMockLocationDetector.echo({ value: inputValue })
}
