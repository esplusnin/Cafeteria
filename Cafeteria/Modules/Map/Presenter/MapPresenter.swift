import Foundation

final class MapPresenter {
    
    // MARK: - Dependencies:
    weak var view: MapViewControllerInputProtocol?
    
    private let interactor: MapInteractorInputProtocol
    private let router: MapRouterInputProtocol
    
    // MARK: - Constants and Variables:
    private var placemarks: [Placemark] = []
    
    // MARK: - Lifecycle:
    init(interactor: MapInteractorInputProtocol, router: MapRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MapInteractorOutputProtocol:
extension MapPresenter: MapViewControllerOutputProtocol {
    func requestPlacemarks() {
        view?.addPlacemarks(from: placemarks)
    }
    
    func goToMenu(with id: Int) {
        router.goToMenu(with: id)
    }
}

// MARK: - MapInteractorOutputProtocol:
extension MapPresenter: MapInteractorOutputProtocol {
    func setup(_ placemarks: [Placemark]) {
        self.placemarks = placemarks
    }
}

// MARK: - MapPresenterInputProtocol:
extension MapPresenter: MapPresenterInputProtocol {
    func transfer(_ locations: [LocationDTO]) {
        interactor.setup(locations)
    }
}
