import Foundation

protocol RegistrationViewInputProtocol: AnyObject {
    func accountDidCreate()
    func accountDidNotCreate()
    func invalidEmailFormat()
    func invalidPasswordFormat()
}
