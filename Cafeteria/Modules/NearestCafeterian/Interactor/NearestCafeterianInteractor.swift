import Foundation

final class NearestCafeterianInteractor {
    
    // MARK: - Dependencies:
    weak var output: NearestCafeterianInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Private Methods:
    
}

// MARK: - NearestCafeterianInteractorInputProtocol:
extension NearestCafeterianInteractor: NearestCafeterianInteractorInputProtocol {
    func fetchLocations() {
        
    }
}
