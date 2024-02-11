import Foundation

final class RegistrationPresenter {
    
    // MARK: - Dependencies:
    weak var view: RegistrationViewInputProtocol?
    
    private let interactor: RegistrationInteractorInputProtocol
    private let router: RegistrationRouterInputProtocol
    
    // MARK: - Lifecycle:
    init(view: RegistrationViewInputProtocol, interactor: RegistrationInteractorInputProtocol, router: RegistrationRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - RegistrationViewOutputProtocol:
extension RegistrationPresenter: RegistrationViewOutputProtocol {
    func createAccount(with login: String, and password: String, repeatedPassword: String) {
        interactor.createNewAccount(with: login, and: password, repeatedPassword: repeatedPassword)
    }
    
    func goToAuthorizationScreen() {
        router.goToAuthorizationScreen()
    }
}

// MARK: - RegistrationInteractorOutputProtocol:
extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func accountDidCreate() {
        router.goToAuthorizationScreen()
    }
    
    func accountDidNotCreate() {
        view?.accountDidNotCreate()
    }
    
    func invalidEmailFormat() {
        view?.invalidEmailFormat()
    }
    
    func invalidPasswordFormat() {
        view?.invalidPasswordFormat()
    }
}
