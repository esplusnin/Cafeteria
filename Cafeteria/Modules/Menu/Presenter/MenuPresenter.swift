import Foundation

final class MenuPresenter {
    
    // MARK: - Dependencies:
    weak var view: MenuViewControllerInputProtocol?
    
    private let interactor: MenuInteractorInputProtocol
    private let router: MenuRouterInputProtocol
    
    private(set) var products: [Product] = [] {
        didSet {
            view?.productsDidDownloaded()
        }
    }
    
    // MARK: - Lifecycle:
    init(interactor: MenuInteractorInputProtocol, router: MenuRouterInputProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - MenuViewControllerOutputProtocol:
extension MenuPresenter: MenuViewControllerOutputProtocol {
    func fetchMenu() {
        interactor.fetchMenu()
    }
    
    func changeProductAmount(with id: Int, newValue: Int) {
        interactor.changeProductAmount(with: id, newValue: newValue)
    }
}

// MARK: - MenuInteractorOutputProtocol:
extension MenuPresenter: MenuInteractorOutputProtocol {
    func transferMenu(with products: [Product]) {
        self.products = products
    }
    
    func menuDidNotDownloaded() {
        view?.productsDidNotDownloaded()
    }
}

// MARK: - MenuPresenterInputProtocol:
extension MenuPresenter: MenuPresenterInputProtocol {
    func setMenu(_ id: Int) {
        interactor.setup(id)
    }
}
