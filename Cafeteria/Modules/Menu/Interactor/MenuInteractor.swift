import Foundation

final class MenuInteractor {
    
    // MARK: - Dependencies:
    weak var output: MenuInteractorOutputProtocol?
    
    private var networkClient: NetworkClientInputProtocol?
}

// MARK: - MenuInteractorInputProtocol:
extension MenuInteractor: MenuInteractorInputProtocol {
    
}
