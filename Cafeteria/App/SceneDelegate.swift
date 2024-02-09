import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        let rootViewController = isFirstEntry() ? NearestCafeterianViewController() : RegistrationViewController()
        let rootNavigationController = UINavigationController(rootViewController: rootViewController)
       
        setup(rootNavigationController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Private Methods:
    private func setup(_ navigationController: UINavigationController) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Asset.Colors.backgroundGray.color
        appearance.titleTextAttributes = [.foregroundColor: Asset.Colors.textBrown.color]
        
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = navigationController.navigationBar.standardAppearance
        navigationController.navigationBar.tintColor = Asset.Colors.textBrown.color
        navigationController.navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
    private func isFirstEntry() -> Bool {
        if let token = KeyChainStorage().token {
            return true
        } else {
            return false
        }
    }
}
