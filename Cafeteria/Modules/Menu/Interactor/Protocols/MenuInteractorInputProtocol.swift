import Foundation

protocol MenuInteractorInputProtocol: AnyObject {
    func setup(_ id: Int)
    func fetchMenu()
    func changeProductAmount(with id: Int, name: String, price: Int, newValue: Int)
    func getOrder() -> Order
    func orderDidChange(order: Order)
}
