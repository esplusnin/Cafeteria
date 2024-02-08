import Foundation

final class RegistrationPresenter {
    
    // MARK: - Dependencies:
    weak var output: RegistrationPresenterOutputProtocol?
    
    private let view: RegistrationViewInputProtocol
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
    func createAccount(with email: String, and password: String, repeatedPassword: String) {
        interactor.createNewAccount(with: email, and: password, repeatedPassword: repeatedPassword)
    }
}

// MARK: - RegistrationInteractorOutputProtocol:
extension RegistrationPresenter: RegistrationInteractorOutputProtocol {
    func accountDidCreate() {
        router.goToNearestCafeterianViewController()
    }
}
