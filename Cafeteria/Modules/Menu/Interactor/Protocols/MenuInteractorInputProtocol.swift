import Foundation

protocol MenuInteractorInputProtocol: AnyObject {
    func setup(_ id: Int)
    func fetchMenu()
    func changeProductAmount(with id: Int, newValue: Int)
}
