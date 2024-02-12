import Foundation

protocol MenuPresenterInputProtocol: AnyObject {
    func setMenu(_ id: Int)
    func orderDidChange(order: Order)
}
