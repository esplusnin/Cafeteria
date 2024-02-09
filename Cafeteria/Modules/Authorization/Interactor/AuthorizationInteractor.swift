import Foundation

final class AuthorizationInteractor {
    
    // MARK: - Dependencies:
    weak var output: AuthorizationInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Private Methods:
    private func save(_ token: String) {
        let keyChainStorage = KeyChainStorage()
        keyChainStorage.setNew(token)
    }
}

// MARK: - AuthorizationInteractorInputProtocol:
extension AuthorizationInteractor: AuthorizationInteractorInputProtocol {
    func authorize(with name: String, and password: String) {
        let account = Login(login: name, password: password)
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            
            networkClient.authorize(account) { result in
                switch result {
                case .success(let token):
                    self.save(token)
                    self.output?.accountDidAuthorize()
                case .failure(_ :):
                    self.output?.accountDidNotAuthorize()
                }
            }
        }
    }
}
