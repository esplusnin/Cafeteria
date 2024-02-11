import Foundation

protocol RegistrationInteractorOutputProtocol: AnyObject {
    func accountDidCreate()
    func accountDidNotCreate()
    func invalidEmailFormat()
    func invalidPasswordFormat()
}
