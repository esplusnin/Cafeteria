import Foundation

protocol RegistrationViewOutputProtocol: AnyObject {
    func createAccount(with login: String, and password: String, repeatedPassword: String)
    func goToAuthorizationScreen() 
}
