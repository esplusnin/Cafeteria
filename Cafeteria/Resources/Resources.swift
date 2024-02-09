import Foundation

enum Resources {
    enum KeyChain {
        static let token = "Token"
        static let login = "Login"
        static let password = "Pasword"
    }
    
    enum Network {
        
        static let successHTTPRange = 200..<300
        
        enum Headers {
            static let jsonType = "application/json"
            static let authorization = "Authorization"
            static let bearer = "Bearer "
        }
            
        enum Pathes {
            static let baseURL = "http://147.78.66.203:3210/"
            static let login = "auth/login"
            static let register = "auth/register"
            static let locations = "locations"
        }
        
        enum EndPoint {
            static let login = Resources.Network.Pathes.baseURL + Resources.Network.Pathes.login
            static let register = Resources.Network.Pathes.baseURL + Resources.Network.Pathes.register
            static let locations = Resources.Network.Pathes.baseURL + Resources.Network.Pathes.locations
        }
        
        enum HTTPCodes {
            static let unauthorized = 401
        }
    }
    
    enum Identifiers {
        static let cafeterianCollectionViewCell = "CafeterianCollectionViewCell"
    }
}
