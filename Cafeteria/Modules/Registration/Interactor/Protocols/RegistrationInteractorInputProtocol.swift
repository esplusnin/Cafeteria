import Foundation

protocol RegistrationInteractorInputProtocol: AnyObject {
    func createNewAccount(with email: String, and password: String, repeatedPassword: String)
}
