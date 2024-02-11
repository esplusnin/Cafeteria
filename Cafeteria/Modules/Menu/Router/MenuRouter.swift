import UIKit

final class MenuRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
    weak var presenter: MenuPresenterInputProtocol?
}

extension MenuRouter: MenuRouterInputProtocol {
    
}
