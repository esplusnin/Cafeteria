import Foundation

final class NearestCafeterianInteractor {
    
    // MARK: - Dependencies:
    weak var output: NearestCafeterianInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    private let keyChainStorage = KeyChainStorage()
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Private Methods:
    private func repeatRequest() {
        guard let login = keyChainStorage.login,
              let password = keyChainStorage.password else { return }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            networkClient.authorize(Login(login: login, password: password)) { result in
                switch result {
                case .success(let token):
                    self.keyChainStorage.setNew(token)
                    self.fetchLocations()
                case .failure(let failure):
                    self.output?.locationsDidNotUpdate()
                }
            }
        }
    }
}

// MARK: - NearestCafeterianInteractorInputProtocol:
extension NearestCafeterianInteractor: NearestCafeterianInteractorInputProtocol {
    func fetchLocations() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            networkClient.fetchLocations { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let locations):
                        self.output?.update(locations)
                    case .failure(let error):
                        switch error {
                        case NetworkError.unauthorized:
                            self.repeatRequest()
                        default:
                            self.output?.locationsDidNotUpdate()
                        }
                    }
                }
            }
        }
    }
}
