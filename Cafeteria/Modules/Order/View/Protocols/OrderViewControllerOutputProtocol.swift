import Foundation

protocol OrderViewControllerOutputProtocol: AnyObject {
    var order: Order? { get }
    func changeProductAmount(with id: Int, newValue: Int)
    func synchronizeOrder()
}
