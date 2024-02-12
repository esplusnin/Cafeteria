import Foundation

protocol MenuViewControllerOutputProtocol: AnyObject {
    var products: [Product] { get }
    func fetchMenu()
    func changeProductAmount(with id: Int, name: String, price: Int, newValue: Int)
    func goTouOrderScreen()
}
