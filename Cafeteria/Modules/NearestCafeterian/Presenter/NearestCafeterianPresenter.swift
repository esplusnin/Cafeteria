import Foundation

final class NearestCafeterianPresenter {
    
    // MARK: - Dependencies:
    weak var view: NearestCafeterianViewControllerInputProtocol?
    
    private let interactor: NearestCafeterianInteractorInputProtocol
    private let router: NearestCafeterianRouterInputProtocol
    private let output: NearestCafeterianPresenterOutputProtocol
    
    // MARK: - Constants and Variables:
    private(set) var locations: [Location] = [] {
        didSet {
            view?.updateLocationsList()
        }
    }
    
    // MARK: - Lifecycle:
    init(interactor: NearestCafeterianInteractorInputProtocol, router: NearestCafeterianRouterInputProtocol, output: NearestCafeterianPresenterOutputProtocol) {
        self.interactor = interactor
        self.router = router
        self.output = output
    }
}

// MARK: - NearestCafeterianViewControllerInputProtocol:
extension NearestCafeterianPresenter: NearestCafeterianViewOutputProtocol {
    func fetchLocations() {
        interactor.requestLocations()
    }
    
    func goToMap() {
        if let locations = interactor.getLocationsData() {
            output.goToMap(with: locations)
        } else {
            router.goToMap()
        }
    }
}

// MARK: - NearestCafeterianInteractorOutputProtocol:
extension NearestCafeterianPresenter: NearestCafeterianInteractorOutputProtocol {
    func update(_ locations: [Location]) {
        self.locations = locations
    }
    
    func locationsDidNotUpdate() {
        #warning("Обработчик")
    }
}
