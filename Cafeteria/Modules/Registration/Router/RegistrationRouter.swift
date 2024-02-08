import UIKit

final class RegistrationRouter {
    
    // MARK: - Dependencies:
    weak var navigation: UINavigationController?
}

// MARK: - RegistrationRouterInputProtocol:
extension RegistrationRouter: RegistrationRouterInputProtocol {
    func goToNearestCafeterianViewController() {
        let viewController = EnterViewController()
        navigation?.pushViewController(viewController, animated: true)
    }
}
