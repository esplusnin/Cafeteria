import Foundation

protocol NetworkClientInputProtocol: AnyObject {
    func registerNew(_ account: Account, completion: @escaping (Result<String, Error>) -> Void)
    func authorize(_ login: Login, completion: @escaping (Result<String, Error>) -> Void)
    func fetchLocations(completion: @escaping (Result<[Location], Error>) -> Void)
}
