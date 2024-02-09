import Foundation

final class NearestCafeterianConfigurator {
    func configure(_ controller: NearestCafeterianViewController) {
        let networkClient = NetworkClient()
        let interactor = NearestCafeterianInteractor(networkClient: networkClient)
        let router = NearestCafeterianRouter()
        let presenter = NearestCafeterianPresenter(interactor: interactor, router: router)
        
        controller.setup(presenter)
        presenter.view = controller
        interactor.output = presenter
        router.navigation = controller.navigationController
    }
}
