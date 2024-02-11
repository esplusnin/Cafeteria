import Foundation
import KeychainAccess

final class KeyChainStorage {
    
    // MARK: - Classes:
    private let keyChain = Keychain()
    
    // MARK: - Constants and Variables:
    private(set) var token: String? {
        get {
            keyChain[Resources.KeyChain.token]
        }
        set {
            keyChain[Resources.KeyChain.token] = newValue
        }
    }
    
    private(set) var login: String? {
        get {
            keyChain[Resources.KeyChain.login]
        }
        set {
            keyChain[Resources.KeyChain.login] = newValue
        }
    }
    
    private(set) var password: String? {
        get {
            keyChain[Resources.KeyChain.login]
        }
        set {
            keyChain[Resources.KeyChain.login] = newValue
        }
    }
    
    // MARK: - Public Methods:
    func setNew(_ token: String, _ login: String? = nil, _ password: String? = nil) {
        self.token = token
        self.login = login
        self.password = password
    }
}
