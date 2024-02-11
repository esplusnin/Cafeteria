import Foundation

final class MapInteractor {
    
    weak var output: MapInteractorOutputProtocol?
    
}

extension MapInteractor: MapInteractorInputProtocol {
    
}
