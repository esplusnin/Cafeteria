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
    
    func changeProductAmount(with id: Int, name: String, price: Int, newValue: Int) {
        interactor.changeProductAmount(with: id, name: name, price: price, newValue: newValue)
    }
    
    func goTouOrderScreen() {
        let order = interactor.getOrder()
        router.goToOrderScreen(with: order)
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
    
    func menuDidEditedFromOrder() {
        let order = interactor.getOrder()
        view?.updatePotential(order)
    }
}

// MARK: - MenuPresenterInputProtocol:
extension MenuPresenter: MenuPresenterInputProtocol {
    func setMenu(_ id: Int) {
        interactor.setup(id)
    }
    
    func orderDidChange(order: Order) {
        interactor.orderDidChange(order: order)
    }
}
