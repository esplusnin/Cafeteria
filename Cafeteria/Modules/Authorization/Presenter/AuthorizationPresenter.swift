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
    func authorize(with login: String, and password: String) {
        interactor.authorize(with: login, and: password)
    }
}

// MARK: - AuthorizationInteractorOutputProtocol:
extension AuthorizationPresenter: AuthorizationInteractorOutputProtocol {
    func accountDidAuthorize() {
        view?.accountDidAuthorize()
        router.goToNearestCafeterianScreen()
    }
    
    func accountDidNotAuthorize() {
        #warning("обработчик ошибок")
    }
}
