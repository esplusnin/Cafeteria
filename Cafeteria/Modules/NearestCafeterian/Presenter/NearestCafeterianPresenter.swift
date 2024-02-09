import Foundation

final class NearestCafeterianPresenter {
    
    // MARK: - Dependencies:
    weak var view: NearestCafeterianViewControllerInputProtocol?
    
    private let interactor: NearestCafeterianInteractorInputProtocol
    private let router: NearestCafeterianRouterInputProtocol
    
    // MARK: - Lifecycle:
    init(interactor: NearestCafeterianInteractorInputProtocol, router: NearestCafeterianRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - NearestCafeterianViewControllerInputProtocol:
extension NearestCafeterianPresenter: NearestCafeterianViewOutputProtocol {
    func fetchLocations() {
        
    }
}

// MARK: - NearestCafeterianInteractorOutputProtocol:
extension NearestCafeterianPresenter: NearestCafeterianInteractorOutputProtocol {
    
}
