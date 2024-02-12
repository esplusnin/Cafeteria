import Foundation

final class RegistrationConfigurator {
    
    // MARK: - Public Methods:
    func configure(_ controller: RegistrationViewController) {
        let networkClient = NetworkClient()
        let interactor = RegistrationInteractor(networkClient: networkClient)
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter(view: controller, interactor: interactor, router: router)
        
        interactor.output = presenter
        controller.setup(presenter)
        router.navigation = controller.navigationController
    }
}
