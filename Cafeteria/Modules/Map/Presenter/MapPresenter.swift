import Foundation

final class MapPresenter {
    
    // MARK: - Dependencies:
    weak var view: MapViewControllerInputProtocol?
    
    private let interactor: MapInteractorInputProtocol
    private let router: MapRouterInputProtocol
    
    // MARK: - Lifecycle:
    init(interactor: MapInteractorInputProtocol, router: MapRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MapInteractorOutputProtocol:
extension MapPresenter: MapInteractorOutputProtocol {
    
}
