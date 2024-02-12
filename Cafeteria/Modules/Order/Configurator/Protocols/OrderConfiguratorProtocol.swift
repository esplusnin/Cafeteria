import Foundation

protocol OrderConfiguratorProtocol: AnyObject {
    func configure(_ controller: OrderViewController, with order: Order, delegate: OrderRouterDelegate)
}
