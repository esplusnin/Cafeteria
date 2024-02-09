import Foundation

struct AuthorizationDTO: Decodable {
    let token: String
    let tokenLifetime: Int
}
