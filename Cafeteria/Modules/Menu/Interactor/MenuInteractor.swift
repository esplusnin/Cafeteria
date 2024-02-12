import Foundation

final class MenuInteractor {
    
    // MARK: - Dependencies:
    weak var output: MenuInteractorOutputProtocol?
    
    private var networkClient: NetworkClientInputProtocol?
    
    // MARK: - Constants and Variables:
    private var products: [Product] = [] {
        didSet {
            output?.transferMenu(with: products)
        }
    }
    
    private var potentialOrder = Order(products: [])
    
    private var menuID: Int?
}

// MARK: - MenuInteractorInputProtocol:
extension MenuInteractor: MenuInteractorInputProtocol {
    func setup(_ id: Int) {
        menuID = id
    }
    
    func fetchMenu() {
        guard let menuID else { return }
        networkClient = NetworkClient()
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let self else { return }
            networkClient?.fetchProducts(with: menuID) { result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let products):
                        self.products = products
                    case .failure(_ :):
                        self.output?.menuDidNotDownloaded()
                    }
                }
            }
        }
    }
    
    func changeProductAmount(with id: Int, newValue: Int) {
        if let index = potentialOrder.products.firstIndex(where: { $0.id == id }) {
            if newValue == 0 {
                potentialOrder.products.remove(at: index)
            } else {
                potentialOrder.products[index].changeValue(to: newValue)
            }
        } else {
            potentialOrder.products.append(ProductDTO(id: id, amount: newValue))
        }
    }
}
