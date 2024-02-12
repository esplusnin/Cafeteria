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
    
}
