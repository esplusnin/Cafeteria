import Foundation

final class NearestCafeterianInteractor {
    
    // MARK: - Dependencies:
    weak var output: NearestCafeterianInteractorOutputProtocol?
    
    private var networkClient: NetworkClientInputProtocol?
    
    // MARK: - Classes:
    private let keyChainStorage = KeyChainStorage()
    private let locationManager = LocationManager()
    
    // MARK: - Constants and Variables:
    private var locations: [LocationDTO]?
    
    private let kilometerInMeters = 1000
    private let roundedValue: Double = 100000
    
    // MARK: - Lifecycle:
    init() {
        self.locationManager.delegate = self
    }
    
    // MARK: - Private Methods:
    private func fetchLocations() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            networkClient = NetworkClient()
            
            networkClient?.fetchLocations { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let locationsDTO):
                        self.locations = locationsDTO
                        
                        let locations = locationsDTO.map {
                            let distance = self.locationManager.defineDistance(latitude: Double($0.point.latitude),
                                                                               longitude: Double($0.point.longitude))
                            let distanceString = self.convert(distance)
                            
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
                            self.networkClient = nil
                            self.output?.locationsDidNotUpdate()
                        }
                    }
                }
            }
        }
    }
    
    private func repeatRequest() {
        guard let login = keyChainStorage.login,
              let password = keyChainStorage.password else { return }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            networkClient?.authorize(Login(login: login, password: password)) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let token):
                        self.keyChainStorage.setNew(token, login, password)
                        self.requestLocations()
                    case .failure(_ :):
                        self.output?.locationsDidNotUpdate()
                    }
                    
                    self.networkClient = nil
                }
            }
        }
    }
    
    private func convert(_ distance: Double?) -> String {
        guard let distance  else { return "" }
        let roundedDistance = (distance * roundedValue).rounded() / roundedValue
        
        if Int(distance) < kilometerInMeters {
            return String(describing: Int(roundedDistance)) + L10n.NearestCafeterian.m + L10n.NearestCafeterian.fromYou
        } else {
            let distanceInKilometers = Int(roundedDistance) / kilometerInMeters
            return String(describing: distanceInKilometers) + L10n.NearestCafeterian.km + L10n.NearestCafeterian.fromYou
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
    
    func getLocationsData() -> [LocationDTO]? {
        locations
    }
}

// MARK: - LocationManagerDelegate:
extension NearestCafeterianInteractor: LocationManagerDelegate {
    func userChangeAuthorizationStatus() {
        fetchLocations()
    }
    
    func locationDidNotAllowed() {
        output?.locationsDidNotUpdate()
    }
}
