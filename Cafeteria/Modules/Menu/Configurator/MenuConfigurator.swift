import Foundation

final class MenuConfigurator: MenuConfiguratorProtocol {
    
    // MARK: - Public Methods:
    func configure(_ controller: MenuViewController, with id: Int) {
        let interactor = MenuInteractor()
        let router = MenuRouter()
        let presenter = MenuPresenter(interactor: interactor, router: router)
        
        controller.setup(presenter)
        presenter.view = controller
        interactor.output = presenter
        router.presenter = presenter
        router.navigation = controller.navigationController
        
        router.setup(id)
    }
}
