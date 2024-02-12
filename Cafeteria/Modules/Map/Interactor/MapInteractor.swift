import Foundation

final class MapInteractor {
    
    // MARK: - Dependencies:
    weak var output: MapInteractorOutputProtocol?
    
    // MARK: - Constants and Variables:
    private var locations: [LocationDTO] = [] {
        didSet {
            convertToPlacemarks()
        }
    }
    
    // MARK: - Private Methods:
    func convertToPlacemarks() {
        var placemarks: [Placemark] = []
        
        locations.forEach {
            guard let latitude = Double($0.point.latitude),
                  let longitude = Double($0.point.longitude) else { return }
            
            placemarks.append(Placemark(id: $0.id,
                                        name: $0.name,
                                        latitude: latitude,
                                        longitude: longitude))
        }
        
        output?.setup(placemarks)
    }
}

// MARK: - MapInteractorInputProtocol:
extension MapInteractor: MapInteractorInputProtocol {
    func setup(_ locationData: [LocationDTO]) {
        self.locations = locationData
    }
}
