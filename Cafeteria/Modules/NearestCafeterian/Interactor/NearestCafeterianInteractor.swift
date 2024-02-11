import Foundation

final class NearestCafeterianInteractor {
    
    // MARK: - Dependencies:
    weak var output: NearestCafeterianInteractorOutputProtocol?
    
    private let networkClient: NetworkClientInputProtocol
    private let keyChainStorage = KeyChainStorage()
    private let locationManager = LocationManager()
    
    // MARK: - Lifecycle:
    init(networkClient: NetworkClientInputProtocol) {
        self.networkClient = networkClient
        self.locationManager.delegate = self
    }

    // MARK: - Private Methods:
    private func fetchLocations() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            
            networkClient.fetchLocations { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let locationsDTO):
                        let converter = DistanceConverter()
    
                        let locations = locationsDTO.map {
                            let distance = self.locationManager.defineDistance(latitude: Double($0.point.latitude),
                                                                               longitude: Double($0.point.longitude))
                            let distanceString = converter.convert(distance)
                            
                            return Location(id: $0.id,
                                     name: $0.name,
                                     distance: distanceString)
                        }
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
    
    private func repeatRequest() {
    print("1")
        print(keyChainStorage.login, keyChainStorage.password)
        guard let login = keyChainStorage.login,
              let password = keyChainStorage.password else { return }
        print("2")
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            networkClient.authorize(Login(login: login, password: password)) { result in
                switch result {
                case .success(let token):
                    self.keyChainStorage.setNew(token)
                    self.requestLocations()
                case .failure(_ :):
                    self.output?.locationsDidNotUpdate()
                }
            }
        }
    }
}

// MARK: - NearestCafeterianInteractorInputProtocol:
extension NearestCafeterianInteractor: NearestCafeterianInteractorInputProtocol {
    func requestLocations() {
        if locationManager.isAuthorized {
            fetchLocations()
        } else {
            locationManager.requestAuthorization()
        }
    }
}

// MARK: - LocationManagerDelegate:
extension NearestCafeterianInteractor: LocationManagerDelegate {
    func userChangeAuthorizationStatus() {
        fetchLocations()
    }
}
