import Foundation
import KeychainAccess

final class KeyChainStorage {
    
    // MARK: - Classes:
    private let keyChain = Keychain()
    
    // MARK: - Constants and Variables:
    private var token: String? {
        get {
            keyChain[Resources.KeyChain.token]
        }
        set {
            keyChain[Resources.KeyChain.token] = newValue
        }
    }
    
    // MARK: - Public Methods:
    func setNew(_ token: String) {
        self.token = token
    }
}
