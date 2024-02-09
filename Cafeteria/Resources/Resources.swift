import Foundation

enum Resources {
    enum KeyChain {
        static let token = "Token"
    }
    
    enum Network {
        
        static let successHTTPRange = 200..<300
        static let jsonType = "application/json"
        
        enum Pathes {
            static let baseURL = "http://147.78.66.203:3210/"
            static let login = "auth/login"
            static let register = "auth/register"
        }
        
        enum EndPoint {
            static let login = Resources.Network.Pathes.baseURL + Resources.Network.Pathes.login
            static let register = Resources.Network.Pathes.baseURL + Resources.Network.Pathes.register
        }
    }
}
