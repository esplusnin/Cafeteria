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
                switch result {
                case .success(let products):
                    self.products = products
                case .failure(let error):
                    self.output?.menuDidNotDownloaded()
                }
            }
        }
    }
}
