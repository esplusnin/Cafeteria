import Foundation

protocol MenuInteractorInputProtocol: AnyObject {
    func setup(_ id: Int)
    func fetchMenu()
}
