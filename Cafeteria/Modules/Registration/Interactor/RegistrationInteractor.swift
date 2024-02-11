import Foundation

final class RegistrationInteractor {
    
    // MARK: - Dependencies:
    weak var output: RegistrationInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Constants and Variables:
    private let minPasswordCharacter = 4
    
    // MARK: - Private Methods:
    private func checkAccountDetail(login: String, password: String, repeatedPassword: String) {

        guard isValidEmail(login) else {
            output?.invalidEmailFormat()
            return
        }
        
        guard isValidPassword(password, repeatedPassword) else {
            output?.invalidPasswordFormat()
            return
        }

        let account = Account(login: login, password: password)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            
            self.networkClient.registerNew(account) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let token):
                        self.save(token, login, password)
                    case .failure(_ :):
                        self.output?.accountDidNotCreate()
                    }
                }
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = Resources.AccountValidation.regexValues
        let emailPredicate = NSPredicate(format:Resources.AccountValidation.emailPredicate, emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String, _ repeatedPassword: String) -> Bool {
        return password.count >= minPasswordCharacter && password == repeatedPassword
    }
    
    private func save(_ token: String, _ login: String, _ password: String) {
        let keyChainStorage = KeyChainStorage()
        keyChainStorage.setNew(token, login, password)
        
        output?.accountDidCreate()
    }
}

// MARK: - RegistrationInteractorInputProtocol:
extension RegistrationInteractor: RegistrationInteractorInputProtocol {
    func createNewAccount(with login: String, and password: String, repeatedPassword: String) {
        checkAccountDetail(login: login, password: password, repeatedPassword: repeatedPassword)
    }
}
