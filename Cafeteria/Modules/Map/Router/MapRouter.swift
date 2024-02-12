import UIKit

final class MapRouter {
    
    // MARK: - Dependencies:
    weak var presenter: MapPresenterInputProtocol?
    weak var navigation: UINavigationController?
    
    // MARK: - Publc Methods:
    func transfer(_ locations: [LocationDTO]) {
        presenter?.transfer(locations)
    }
}

// MARK: - MapInteractorInputProtocol:
extension MapRouter: MapRouterInputProtocol {
    func goToMenu(with id: Int) {
        let configurator = MenuConfigurator()
        let viewController = MenuViewController(configurator: configurator)
        
        navigation?.pushViewController(viewController, animated: true)
        configurator.configure(viewController, with: id)
    }
}
