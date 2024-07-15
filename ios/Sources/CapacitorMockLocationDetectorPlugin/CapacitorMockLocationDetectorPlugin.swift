import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorMockLocationDetectorPlugin)
public class CapacitorMockLocationDetectorPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "CapacitorMockLocationDetectorPlugin"
    public let jsName = "CapacitorMockLocationDetector"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = CapacitorMockLocationDetector()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }
}
