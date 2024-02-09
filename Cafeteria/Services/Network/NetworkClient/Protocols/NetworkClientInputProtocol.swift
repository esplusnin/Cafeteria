import Foundation

protocol NetworkClientInputProtocol: AnyObject {
    func registerNew(_ account: Account, completion: @escaping (Result<String, Error>) -> Void)
    func enter(_ login: Login, completion: @escaping (Result<String, Error>) -> Void)
}
