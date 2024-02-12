import Foundation

protocol LocationManagerDelegate: AnyObject {
    func userChangeAuthorizationStatus()
    func locationDidNotAllowed()
}
