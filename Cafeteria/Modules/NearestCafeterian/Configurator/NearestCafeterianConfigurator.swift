import Foundation

final class NearestCafeterianConfigurator {
    func configure(_ controller: NearestCafeterianViewController) {
        let networkClient = NetworkClient()
        let interactor = NearestCafeterianInteractor()
        let router = NearestCafeterianRouter()
        let presenter = NearestCafeterianPresenter(interactor: interactor, router: router, output: router)
        
        controller.setup(presenter)
        presenter.view = controller
        interactor.output = presenter
        router.navigation = controller.navigationController
    }
}
