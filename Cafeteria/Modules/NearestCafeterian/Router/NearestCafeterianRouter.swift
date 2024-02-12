import UIKit

final class NearestCafeterianRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
}

// MARK: - NearestCafeterianRouterInputProtocol:
extension NearestCafeterianRouter: NearestCafeterianRouterInputProtocol {
    func goToMap(with locationData: [LocationDTO]) {
        let configurator = MapConfigurator()
        let viewController = MapViewController(configurator: configurator)
        
        navigation?.pushViewController(viewController, animated: true)
        configurator.configure(viewController, with: locationData)
    }
    
    func goToMenu(with id: Int) {
        let configurator = MenuConfigurator()
        let viewController = MenuViewController(configurator: configurator)
        
        navigation?.pushViewController(viewController, animated: true)
        configurator.configure(viewController, with: id)
    }
}
