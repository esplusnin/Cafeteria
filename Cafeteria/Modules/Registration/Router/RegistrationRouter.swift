import UIKit

final class RegistrationRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
}

// MARK: - RegistrationRouterInputProtocol:
extension RegistrationRouter: RegistrationRouterInputProtocol {
    func goToAuthorizationScreen() {
        let viewController = AuthorizationViewController()
        navigation?.pushViewController(viewController, animated: true)
    }
    
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
