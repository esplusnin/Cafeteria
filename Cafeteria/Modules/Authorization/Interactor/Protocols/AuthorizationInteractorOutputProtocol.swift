import Foundation

protocol AuthorizationInteractorOutputProtocol: AnyObject {
    func accountDidAuthorize()
    func accountDidNotAuthorize()
}
