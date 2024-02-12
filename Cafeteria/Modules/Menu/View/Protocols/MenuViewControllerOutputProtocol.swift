import Foundation

protocol MenuViewControllerOutputProtocol: AnyObject {
    var products: [Product] { get }
    func fetchMenu()
    func changeProductAmount(with id: Int, newValue: Int)
}
