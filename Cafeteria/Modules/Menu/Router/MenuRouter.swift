import UIKit

final class MenuRouter {
    
    // MARK: - Dependencies:
    weak var presenter: MenuPresenterInputProtocol?
    weak var navigation: UINavigationController?
    
    // MARK: - Public Methods:
    func setup(_ id: Int) {
        presenter?.setMenu(id)
    }
}

// MARK: - MenuRouterInputProtocol:
extension MenuRouter: MenuRouterInputProtocol {
    func goToOrderScreen(with order: Order) {
        let configurator = OrderConfigurator()
        let viewController = OrderViewController(configurator: configurator)
        navigation?.pushViewController(viewController, animated: true)
        viewController.configurator.configure(viewController, with: order, delegate: self)
    }
}

extension MenuRouter: OrderRouterDelegate {
    func change(_ order: Order) {
        presenter?.orderDidChange(order: order)
    }
}
