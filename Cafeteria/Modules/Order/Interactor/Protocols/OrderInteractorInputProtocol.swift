import Foundation

protocol OrderInteractorInputProtocol: AnyObject {
    func setup(_ order: Order)
    func changeProductAmount(with id: Int, newValue: Int)
    func getOrder() -> Order
}
