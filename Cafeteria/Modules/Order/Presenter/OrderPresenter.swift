import Foundation

final class OrderPresenter {
    
    // MARK: - Dependencies:
    weak var view: OrderViewControllerInputProtocol?
    
    private let interactor: OrderInteractorInputProtocol
    private let router: OrderRouterInputProtocol
    
    // MARK: - Constants and Variables:
    private(set) var order: Order? {
        didSet {
            view?.orderDidUpdate()
        }
    }
    
    // MARK: - Lifecycle:
    init(interactor: OrderInteractorInputProtocol, router: OrderRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - OrderPresenterInputProtocol:
extension OrderPresenter: OrderPresenterInputProtocol {
    func transfer(_ order: Order) {
        interactor.setup(order)
    }
}

// MARK: - OrderViewControllerOutputProtocol:
extension OrderPresenter: OrderViewControllerOutputProtocol {
    
}

// MARK: - OrderViewControllerOutputProtocol:
extension OrderPresenter: OrderInteractorOutputProtocol {
    func orderDidChange(_ order: Order) {
        self.order = order
    }
}
