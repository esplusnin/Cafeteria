import Foundation

protocol MenuViewControllerInputProtocol: AnyObject {
    func productsDidDownloaded()
    func productsDidNotDownloaded()
    func updatePotential(_ order: Order)
}
