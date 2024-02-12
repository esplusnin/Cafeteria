import Foundation

final class OrderPresenter {
    
    // MARK: - Dependencies:
    weak var view: OrderViewControllerInputProtocol?
    
    private let interactor: OrderInteractorInputProtocol
    private let router: OrderRouterInputProtocol
    
    // MARK: - Lifecycle:
    init(interactor: OrderInteractorInputProtocol, router: OrderRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - OrderViewControllerOutputProtocol:
extension OrderPresenter: OrderViewControllerOutputProtocol {
    
}

// MARK: - OrderViewControllerOutputProtocol:
extension OrderPresenter: OrderInteractorOutputProtocol {
    
}

