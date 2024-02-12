import Foundation

protocol MenuViewControllerOutputProtocol: AnyObject {
    var products: [Product] { get }
    func fetchMenu()
}
