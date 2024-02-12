import Foundation

final class MapConfigurator: MapConfiguratorProtocol {
    
    // MARK: - Public Methods:
    func configure(_ controller: MapViewController, with locationData: [LocationDTO]? = nil) {
        let interactor = MapInteractor()
        let router = MapRouter()
        let presenter = MapPresenter(interactor: interactor, router: router)
        
        controller.setup(presenter)
        presenter.view = controller
        interactor.output = presenter
        router.presenter = presenter
        router.navigation = controller.navigationController
        
        if let locationData {
            router.transfer(locationData)
        }        
    }
}
