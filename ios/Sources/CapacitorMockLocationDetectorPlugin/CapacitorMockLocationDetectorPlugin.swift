import Foundation
import Capacitor
import CoreLocation

@objc(CapacitorMockLocationDetectorPlugin)
public class CapacitorMockLocationDetectorPlugin: CAPPlugin, CAPBridgedPlugin, CLLocationManagerDelegate {
    public var identifier = "CapacitorMockLocationDetectorPlugin"
    public var jsName = "CapacitorMockLocationDetector"
    
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "detectMockLocation", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = CapacitorMockLocationDetector()
    private var locationManager: CLLocationManager?
    private var locationCall: CAPPluginCall?

    public override func load() {
        super.load();
        locationManager = CLLocationManager()
        locationManager?.delegate = self
    }

    @objc func detectMockLocation(_ call: CAPPluginCall) {
        print("detectMockLocation called")
        locationCall = call
        
        // Check if location services are enabled
        guard CLLocationManager.locationServicesEnabled() else {
            print("Location services are not enabled.")
            call.reject("Location services are not enabled.")
            return
        }
        
        // Check authorization status
        let authorizationStatus = CLLocationManager.authorizationStatus()
        print("Authorization status: \(authorizationStatus.rawValue)")
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            print("Location authorization granted. Starting location updates.")
            // Start updating location
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
        } else if authorizationStatus == .notDetermined {
            print("Requesting location authorization.")
            // Request location authorization
            locationManager?.requestWhenInUseAuthorization()
        } else {
            print("Location access not authorized.")
            call.reject("Location access not authorized.")
        }
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let call = locationCall else {
            print("No active call to resolve.")
            return
        }
        guard let currentLocation = locations.last else {
            print("Unable to fetch current location.")
            call.reject("Unable to fetch current location.")
            return
        }
        
        print("Location updated: \(currentLocation)")
        
        if #available(iOS 15.0, *) {
            let isSimulated = currentLocation.sourceInformation?.isSimulatedBySoftware ?? false
            let isProducedByAccessory = currentLocation.sourceInformation?.isProducedByAccessory ?? false
            
            print("isSimulatedBySoftware: \(isSimulated)")
            print("isProducedByAccessory: \(isProducedByAccessory)")
            
            if isSimulated || isProducedByAccessory {
                call.resolve(["isMockLocation": true])
            } else {
                call.resolve(["isMockLocation": false])
            }
        } else {
            call.resolve(["isMockLocation": false])
        }
        
        locationManager?.stopUpdatingLocation()
        locationCall = nil
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let call = locationCall else {
            print("No active call to handle authorization change.")
            return
        }
        print("Authorization status changed: \(status.rawValue)")
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            print("Authorization granted. Starting location updates.")
            // Start updating location
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
        } else if status == .denied || status == .restricted {
            print("Location access not authorized.")
            call.reject("Location access not authorized.")
        }
    }
}


