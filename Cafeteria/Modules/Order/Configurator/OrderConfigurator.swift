import Foundation

final class OrderConfigurator: OrderConfiguratorProtocol {
    func configure(_ controller: OrderViewController, with order: Order, delegate: OrderRouterDelegate) {
        let interactor = OrderInteractor()
        let router = OrderRouter()
        let presenter = OrderPresenter(interactor: interactor, router: router)
        
        presenter.view = controller
        controller.setup(presenter)
        interactor.output = presenter
        router.navigation = controller.navigationController
        router.presenter = presenter
        router.delegate = delegate
        
        router.transfer(order)
    }
}
