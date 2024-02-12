import Foundation

final class OrderConfigurator: OrderConfiguratorProtocol {
    func configure(_ controller: OrderViewController) {
        let interactor = OrderInteractor()
        let router = OrderRouter()
        let presenter = OrderPresenter(interactor: interactor, router: router)
        
        presenter.view = controller
        controller.setup(presenter)
        interactor.output = presenter
        router.navigation = controller.navigationController
    }
}
