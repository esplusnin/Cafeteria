import Foundation

final class OrderInteractor {
    
    // MARK: - Dependencies:
    weak var output: OrderInteractorOutputProtocol?
    
    // MARK: - Constants and Variables:
    private var order: Order? {
        didSet {
            guard let order else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.output?.orderDidChange(order)
            }
        }
    }
}

// MARK: - OrderInteractorInputProtocol:
extension OrderInteractor: OrderInteractorInputProtocol {
    func setup(_ order: Order) {
        self.order = order
    }
}
