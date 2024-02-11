import UIKit

final class NearestCafeterianRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
}

// MARK: - NearestCafeterianRouterInputProtocol:
extension NearestCafeterianRouter: NearestCafeterianRouterInputProtocol {
    func goToMap() {
        let configurator = MapConfigurator()
        let viewController = MapViewController(configurator: configurator)
        
        configurator.configure(viewController)
        navigation?.pushViewController(viewController, animated: true)
    }
}

// MARK: - NearestCafeterianPresenterOutputProtocol:
extension NearestCafeterianRouter: NearestCafeterianPresenterOutputProtocol {
    func goToMap(with locationData: [LocationDTO]) {
        let configurator = MapConfigurator()
        let viewController = MapViewController(configurator: configurator)
        
        configurator.configure(viewController, with: locationData)
        navigation?.pushViewController(viewController, animated: true)
    }
}
