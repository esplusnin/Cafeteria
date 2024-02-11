import UIKit
import YandexMapsMobile

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public Methods:
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        YMKMapKit.setApiKey(Resources.Identifiers.YandexMapKey)
        YMKMapKit.sharedInstance()
        
        return true
    }
}
