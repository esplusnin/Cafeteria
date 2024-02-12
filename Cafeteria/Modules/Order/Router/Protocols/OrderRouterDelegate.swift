import Foundation

protocol OrderRouterDelegate: AnyObject {
    func change(_ order: Order)
}
