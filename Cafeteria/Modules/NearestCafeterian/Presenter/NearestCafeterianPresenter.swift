import Foundation

final class NearestCafeterianPresenter {
    
    // MARK: - Dependencies:
    weak var view: NearestCafeterianViewControllerInputProtocol?
    
    private let interactor: NearestCafeterianInteractorInputProtocol
    private let router: NearestCafeterianRouterInputProtocol
    
    // MARK: - Constants and Variables:
    private(set) var locations: [Location] = [] {
        didSet {
            view?.updateLocationsList()
        }
    }
    
    // MARK: - Lifecycle:
    init(interactor: NearestCafeterianInteractorInputProtocol, router: NearestCafeterianRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - NearestCafeterianViewControllerInputProtocol:
extension NearestCafeterianPresenter: NearestCafeterianViewOutputProtocol {
    func fetchLocations() {
        interactor.requestLocations()
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
