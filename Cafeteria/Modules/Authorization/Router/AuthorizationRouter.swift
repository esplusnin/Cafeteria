import UIKit

final class AuthorizationRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
}

// MARK: - AuthorizationRouterInputProtocol:
extension AuthorizationRouter: AuthorizationRouterInputProtocol {
    func goToNearestCafeterianScreen() {
        let viewController = NearestCafeterianViewController()
        navigation?.pushViewController(viewController, animated: true)
        
        navigation?.viewControllers.forEach {
            if $0 != viewController {
                $0.removeFromParent()
            }
        }
    }
}
