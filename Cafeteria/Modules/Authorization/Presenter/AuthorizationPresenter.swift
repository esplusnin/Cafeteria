import Foundation

final class AuthorizationPresenter {
    
    // MARK: - Dependencies:
    weak var view: AuthorizationViewInputProtocol?
    
    private let interactor: AuthorizationInteractorInputProtocol
    private let router: AuthorizationRouterInputProtocol
    
    // MARK: - Lifecycle:
    init(interactor: AuthorizationInteractorInputProtocol, router: AuthorizationRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - AuthorizationViewOutputProtocols:
extension AuthorizationPresenter: AuthorizationViewOutputProtocols {
    
}

// MARK: - AuthorizationInteractorOutputProtocol:
extension AuthorizationPresenter: AuthorizationInteractorOutputProtocol {
    
}
