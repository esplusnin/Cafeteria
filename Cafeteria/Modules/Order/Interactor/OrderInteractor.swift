import Foundation

final class OrderInteractor {
    
    // MARK: - Dependencies:
    weak var output: OrderInteractorOutputProtocol?
}

// MARK: - OrderInteractorInputProtocol:
extension OrderInteractor: OrderInteractorInputProtocol {
    
}
