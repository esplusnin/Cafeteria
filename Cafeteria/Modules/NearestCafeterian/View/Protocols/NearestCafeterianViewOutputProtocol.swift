import Foundation

protocol NearestCafeterianViewOutputProtocol: AnyObject {
    var locations: [Location] { get }
    func fetchLocations()
    func goToMap()
}
