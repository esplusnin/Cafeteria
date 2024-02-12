import Foundation

final class OrderInteractor {
    
    // MARK: - Dependencies:
    weak var output: OrderInteractorOutputProtocol?
    
    // MARK: - Constants and Variables:
    private var order = Order(products: []) {
        didSet {
            if isFirstEntry {
                isFirstEntry = false
                output?.orderDidChange(order)
            }
        }
    }
    
    private var isFirstEntry = true
}

// MARK: - OrderInteractorInputProtocol:
extension OrderInteractor: OrderInteractorInputProtocol {
    func setup(_ order: Order) {
        self.order = order
    }
    
    func changeProductAmount(with id: Int, newValue: Int) {
        if let index = order.products.firstIndex(where: { $0.id == id }) {
            order.products[index].changeValue(to: newValue)
        }
    }
    
    func getOrder() -> Order {
        order
    }
}
