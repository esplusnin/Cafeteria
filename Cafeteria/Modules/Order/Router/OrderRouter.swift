import UIKit

final class OrderRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
    weak var presenter: OrderPresenterInputProtocol?
    weak var delegate: OrderRouterDelegate?
    
    // MARK: - Public Methods:
    func transfer(_ order: Order) {
        presenter?.transfer(order)
    }
}

// MARK: - OrderRouterInputProtocol:
extension OrderRouter: OrderRouterInputProtocol {
    func orderDidChange(order: Order) {
        delegate?.change(order)
    }
}
