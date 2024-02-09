import UIKit

final class AuthorizationRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
}

extension AuthorizationRouter: AuthorizationRouterInputProtocol {
    func goToNearestCafeterianScreen() {
        let viewController = NearestCafeterianViewController()
        navigation?.pushViewController(viewController, animated: true)
    }
}
