import Foundation

final class DistanceConverter {
    
    // MARK: - Constants and Variables:
    private let kilometerInMeters = 1000
    private let roundedValue: Double = 100000
    
    // MARK: - Public Methods:
    func convert(_ distance: Double?) -> String {
        guard let distance  else { return "" }
        let roundedDistance = (distance * roundedValue).rounded() / roundedValue
        
        if Int(distance) < kilometerInMeters {
            return String(describing: Int(roundedDistance)) + L10n.NearestCafeterian.m + L10n.NearestCafeterian.fromYou
        } else {
            let distanceInKilometers = Int(roundedDistance) / kilometerInMeters
            return String(describing: distanceInKilometers) + L10n.NearestCafeterian.km + L10n.NearestCafeterian.fromYou
        }
    }
}
                          
