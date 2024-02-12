import Foundation

final class NearestCafeterianConfigurator {
    
    // MARK: - Public Methods:
    func configure(_ controller: NearestCafeterianViewController) {
        let interactor = NearestCafeterianInteractor()
        let router = NearestCafeterianRouter()
        let presenter = NearestCafeterianPresenter(interactor: interactor, router: router)
        
        controller.setup(presenter)
        presenter.view = controller
        interactor.output = presenter
        router.navigation = controller.navigationController
    }
}
