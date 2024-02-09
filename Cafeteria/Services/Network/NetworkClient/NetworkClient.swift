import Foundation
import Alamofire

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
}
