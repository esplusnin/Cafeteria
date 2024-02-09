import Foundation

protocol RegistrationInteractorInputProtocol: AnyObject {
    func createNewAccount(with login: String, and password: String, repeatedPassword: String)
}
