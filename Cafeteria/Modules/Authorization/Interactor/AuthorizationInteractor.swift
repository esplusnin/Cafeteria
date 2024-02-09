import Foundation

final class AuthorizationInteractor {
    
    // MARK: - Dependencies:
    weak var output: AuthorizationInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
}

// MARK: - AuthorizationInteractorInputProtocol:
extension AuthorizationInteractor: AuthorizationInteractorInputProtocol {
    
}
