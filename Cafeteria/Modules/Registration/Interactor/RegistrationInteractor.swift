import Foundation

final class RegistrationInteractor {
    
    // MARK: - Dependencies:
    weak var output: RegistrationInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Private Methods:
    private func checkAccountDetail(email: String, password: String, repeatedPassword: String) {
        accountDidRegistred()
//        DispatchQueue.global(qos: .userInteractive).async {
//            
//        }
    }
}

// MARK: - RegistrationInteractorInputProtocol:
extension RegistrationInteractor: RegistrationInteractorInputProtocol {
    func createNewAccount(with email: String, and password: String, repeatedPassword: String) {
        checkAccountDetail(email: email, password: password, repeatedPassword: repeatedPassword)
    }
}

// MARK: - NetworkClientOutputProtocol:
extension RegistrationInteractor: NetworkClientOutputProtocol {
    func accountDidRegistred() {
        output?.accountDidCreate()
    }
}
