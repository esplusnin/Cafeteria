import Foundation

final class RegistrationInteractor {
    
    // MARK: - Dependencies:
    weak var output: RegistrationInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Private Methods:
    private func checkAccountDetail(login: String, password: String, repeatedPassword: String) {
        #warning("Добавить проверку валидности значения и вынести работу с нетворк клиентом обратно в RegistrationInteractorInputProtocol")
        let account = Account(login: login, password: password)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            
            self.networkClient.registerNew(account) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let token):
                        self.save(token, login: login, password: password)
                    case .failure(_ :):
                        self.output?.accountDidNotCreate()
                    }
                }
            }
        }
    }
    
    private func save(_ token: String, login: String, password: String) {
        let keyChainStorage = KeyChainStorage()
        
        keyChainStorage.setNew(token)
        keyChainStorage.setNew(login: login)
        keyChainStorage.setNew(password: password)
        
        output?.accountDidCreate()
    }
}

// MARK: - RegistrationInteractorInputProtocol:
extension RegistrationInteractor: RegistrationInteractorInputProtocol {
    func createNewAccount(with login: String, and password: String, repeatedPassword: String) {
        checkAccountDetail(login: login, password: password, repeatedPassword: repeatedPassword)
    }
}
