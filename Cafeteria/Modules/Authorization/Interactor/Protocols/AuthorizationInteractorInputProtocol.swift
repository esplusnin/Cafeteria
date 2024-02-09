import Foundation

protocol AuthorizationInteractorInputProtocol: AnyObject {
    func authorize(with name: String, and password: String)
}
