import UIKit

enum Resources {
    enum KeyChain {
        static let token = "Token"
        static let login = "Login"
        static let password = "Password"
    }
    
    enum Network {
                
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
            static let successHTTPRange = 200..<300
        }
    }
    
    enum AccountValidation {
        static let regexValues = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        static let emailPredicate = "SELF MATCHES %@"
    }
    
    enum Identifiers {
        static let cafeterianCollectionViewCell = "CafeterianCollectionViewCell"
        static let YandexMapKey = "e319bb1b-963b-4a0b-92d1-1a7047178f5d"
    }
    
    enum Symbols {
        static let plus = UIImage(systemName: "plus")?.withTintColor(Asset.Colors.backgroundLightBrown.color, renderingMode: .alwaysOriginal)
        static let minus = UIImage(systemName: "minus")?.withTintColor(Asset.Colors.backgroundLightBrown.color, renderingMode: .alwaysOriginal)
    }
}
