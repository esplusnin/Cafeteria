import Foundation

protocol MenuInteractorOutputProtocol: AnyObject {
    func transferMenu(with products: [Product])
    func menuDidNotDownloaded()
}
