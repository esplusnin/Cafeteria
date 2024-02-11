import Foundation
import CoreLocation

final class LocationManager: NSObject {
    
    // MARK: - Dependencies:
    weak var delegate: LocationManagerDelegate?
    
    // MARK: - Classes:
    private let manager = CLLocationManager()
    
    // MARK: - Constants and Variables:
    var isAuthorized: Bool {
        let status = manager.authorizationStatus
        
        if status == .notDetermined {
            return false
        } else {
            manager.requestLocation()
            return true
        }
    }
    
    private var isUsedBefore = false
    
    // MARK: - Lifecycle:
    override init() {
        super.init()
        self.manager.delegate = self
    }
    
    // MARK: - Public Methods:
    func requestAuthorization() {
        isUsedBefore = true
        manager.requestAlwaysAuthorization()
    }
    
    func isTrackingLocationAllowed() -> Bool {
        let status = manager.authorizationStatus
        
        switch status {
        case .restricted, .notDetermined:
            return false
        default:
            return true
        }
    }
    
    func defineDistance(latitude: Double?, longitude: Double?) -> Double? {
        guard let latitude,
              let longitude,
              let myLocation = CLLocationManager().location else { return nil }
        let toLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distance = myLocation.distance(from: toLocation)

        return distance
    }
}

// MARK: - CLLocationManagerDelegate:
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if isUsedBefore {
            delegate?.userChangeAuthorizationStatus()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {}
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
