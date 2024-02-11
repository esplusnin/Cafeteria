import Foundation

protocol NearestCafeterianInteractorInputProtocol: AnyObject {
    func requestLocations()
    func getLocationsData() -> [LocationDTO]?
}
