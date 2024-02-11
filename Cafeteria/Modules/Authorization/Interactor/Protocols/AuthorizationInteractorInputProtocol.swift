import Foundation

protocol AuthorizationInteractorInputProtocol: AnyObject {
    func authorize(with login: String, and password: String)
}
