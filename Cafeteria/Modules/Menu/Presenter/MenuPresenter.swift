import Foundation

final class MenuPresenter {
    
    // MARK: - Dependencies:
    weak var view: MenuViewControllerInputProtocol?
    
    private let interactor: MenuInteractorInputProtocol
    private let router: MenuRouterInputProtocol
    
    // MARK: - Lifecycle:
    init(interactor: MenuInteractorInputProtocol, router: MenuRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MenuViewControllerOutputProtocol:
extension MenuPresenter: MenuViewControllerOutputProtocol {
    
}

// MARK: - MenuInteractorOutputProtocol:
extension MenuPresenter: MenuInteractorOutputProtocol {
    
}

// MARK: - MenuPresenterInputProtocol:
extension MenuPresenter: MenuPresenterInputProtocol {
    
}
