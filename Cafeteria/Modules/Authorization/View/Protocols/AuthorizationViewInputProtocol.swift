import Foundation

protocol AuthorizationViewInputProtocol: AnyObject {
    func accountDidAuthorize()
    func accountDidNotAuthorize()
}
