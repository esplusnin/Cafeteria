import Foundation

protocol AuthorizationViewOutputProtocols: AnyObject {
    func authorize(with login: String, and password: String)
}
