import Foundation

protocol RegistrationViewOutputProtocol: AnyObject {
    func createAccount(with email: String, and password: String, repeatedPassword: String)
}
