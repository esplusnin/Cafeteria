import Foundation

protocol MapViewControllerOutputProtocol: AnyObject {
    func requestPlacemarks()
    func goToMenu(with id: Int)
}
