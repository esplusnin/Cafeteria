import Foundation

protocol OrderInteractorOutputProtocol: AnyObject {
    func orderDidChange(_ order: Order) 
}
