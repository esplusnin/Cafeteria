import Foundation

protocol RegistrationViewInputProtocol: AnyObject {
    func accountDidNotCreate()
    func invalidEmailFormat()
    func invalidPasswordFormat()
}
