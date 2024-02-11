import Foundation

protocol MapViewControllerInputProtocol: AnyObject {
    func addPlacemarks(from locations: [Placemark])
}
