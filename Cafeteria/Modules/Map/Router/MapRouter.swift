import UIKit

final class MapRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
    weak var presenter: MapPresenterInputProtocol?
    
    // MARK: - Publc Methods:
    func transfer(_ locations: [LocationDTO]) {
        presenter?.transfer(locations)
    }
}

// MARK: - MapInteractorInputProtocol:
extension MapRouter: MapRouterInputProtocol {
    
}
