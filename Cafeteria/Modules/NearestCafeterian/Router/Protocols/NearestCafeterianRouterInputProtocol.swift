import Foundation

protocol NearestCafeterianRouterInputProtocol: AnyObject {
    func goToMap(with locationData: [LocationDTO])
    func goToMenu(with id: Int)
}
