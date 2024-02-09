import UIKit

final class AuthorizationConfigurator {
    
    // MARK: - Public Methods:
    func configute(_ controller: AuthorizationViewController) {
        let networkClient = NetworkClient()
        let interactor = AuthorizationInteractor(networkClient: networkClient)
        let router = AuthorizationRouter()
        let presenter = AuthorizationPresenter(interactor: interactor, router: router)
        
        controller.setup(presenter)
        presenter.view = controller
        interactor.output = presenter
        router.navigation = controller.navigationController
    }
}
