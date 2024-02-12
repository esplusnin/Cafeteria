import Foundation
import Alamofire

enum NetworkError: Error {
    case unauthorized
}

final class NetworkClient: NetworkClientInputProtocol {
    
    // MARK: - Public Methods:
    func registerNew(_ account: Account, completion: @escaping (Result<String, Error>) -> Void) {
        
        AF.request(Resources.Network.EndPoint.register,
                   method: .post,
                   parameters: account,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: AuthorizationDTO.self) { response in
            switch response.result {
            case .success(let registrationDTO):
                let token = registrationDTO.token
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func authorize(_ login: Login, completion: @escaping (Result<String, Error>) -> Void) {
        
        AF.request(Resources.Network.EndPoint.login,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).responseDecodable(of: AuthorizationDTO.self) { response in
            
            switch response.result {
            case .success(let registrationDTO):
                let token = registrationDTO.token
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchLocations(completion: @escaping (Result<[LocationDTO], Error>) -> Void) {
        guard let token = KeyChainStorage().token else { return }
        let headers: HTTPHeaders = [Resources.Network.Headers.authorization: Resources.Network.Headers.bearer + token]

        AF.request(Resources.Network.EndPoint.locations, headers: headers).responseDecodable(of: [LocationDTO].self) { response in
            switch response.result {
            case .success(let locations):
                completion(.success(locations))
            case .failure(let error):
                if response.response?.statusCode == Resources.Network.HTTPCodes.unauthorized {
                    completion(.failure(NetworkError.unauthorized))
                } else {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchProducts(with id: Int, completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let token = KeyChainStorage().token else { return }
        let urlString = Resources.Network.EndPoint.getMenuEndPoint(with: id)
        let headers: HTTPHeaders = [Resources.Network.Headers.authorization: Resources.Network.Headers.bearer + token]
        
        AF.request(urlString, headers: headers).responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
