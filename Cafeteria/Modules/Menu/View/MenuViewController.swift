import UIKit

final class MenuViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: MenuViewControllerOutputProtocol?
    
    // MARK: - Classes:
    let configurator: MenuConfiguratorProtocol
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let cellHeight: CGFloat = 205
        static let sideInset: CGFloat = 16
        static let buttonBottomInset: CGFloat = 32
        static let cellHorizontalSpacing: CGFloat = 13
        static let countOfCellInRow: CGFloat = 2
    }
    
    // MARK: - UI:
    private lazy var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.menuCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var goToPayButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Menu.goToPay, for: .normal)
        button.titleLabel?.font = .largeTitleBold
        return button
    }()
    
    // MARK: - Lifecycle
    init(configurator: MenuConfiguratorProtocol) {
        self.configurator = configurator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
        blockUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        output?.fetchMenu()
    }
    
    // MARK: - Public Methods:
    func setup(_ output: MenuViewControllerOutputProtocol) {
        self.output = output
    }
    
    // MARK: - Private Methods:
    private func updateCollectionView() {
        let newAmount = output?.products.count ?? 0
        
        if menuCollectionView.visibleCells.count == 0 {
            menuCollectionView.performBatchUpdates {
                for index in (0..<newAmount) {
                    menuCollectionView.insertItems(at: [IndexPath(row: index, section: 0)])
                }
            }
        } else {
            menuCollectionView.reloadData()
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func goToOrderScreen() {
        output?.goTouOrderScreen()
    }
}

// MARK: - MenuViewControllerInputProtocol:
extension MenuViewController: MenuViewControllerInputProtocol {
    func productsDidDownloaded() {
        updateCollectionView()
        unblock()
    }
    
    func productsDidNotDownloaded() {
        unblock()
        showBanner(subtitle: L10n.Warning.menuDidNotDownloaded)
    }
    
    func updatePotential(_ order: Order) {
        guard let cells = menuCollectionView.visibleCells as? [MenuCollectionViewCell] else { return }
        
        for productDTO in order.products {
            for (index, cell) in cells.enumerated() where productDTO.name == cell.product?.name {
                cells[index].setupCounter(value: productDTO.amount)
            }
        }
    }
}

// MARK: - MenuCollectionViewCellDelegate:
extension MenuViewController: MenuCollectionViewCellDelegate {
    func changeProductAmount(with id: Int, name: String, price: Int, newValue: Int) {
        output?.changeProductAmount(with: id, name: name, price: price, newValue: newValue)
    }
}

// MARK: - UICollectionViewDataSource:
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.menuCollectionViewCell, for: indexPath) as? MenuCollectionViewCell,
              let products = output?.products else { return UICollectionViewCell() }
        
        cell.delegate = self
        cell.setupModel(products[indexPath.row])
        cell.setup(state: .menu)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insetSum = (LocalUIConstants.sideInset * LocalUIConstants.countOfCellInRow) + LocalUIConstants.cellHorizontalSpacing
        let width = (view.frame.width - insetSum) / LocalUIConstants.countOfCellInRow
        
        return CGSize(width: width, height: LocalUIConstants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        LocalUIConstants.cellHorizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LocalUIConstants.cellHorizontalSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: LocalUIConstants.sideInset,
                     left: LocalUIConstants.sideInset,
                     bottom: LocalUIConstants.sideInset,
                     right: LocalUIConstants.sideInset)
    }
}

// MARK: - Setup Views:
extension MenuViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Menu.title
        navigationItem.backButtonDisplayMode = .minimal
        
        [menuCollectionView, goToPayButton].forEach(view.addSubview)
    }
}

// MARK: - Setup Constraints:
extension MenuViewController {
    func setupConstraints() {
        setupMenuCollectionViewConstraints()
        setupGoToPayButtonConstraints()
    }
    
    func setupMenuCollectionViewConstraints() {
        menuCollectionView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(goToPayButton.snp.top).inset(-GlobalUIConstants.baseInset)
        }
    }
    
    func setupGoToPayButtonConstraints() {
        goToPayButton.snp.makeConstraints { make in
            make.left.equalTo(LocalUIConstants.sideInset)
            make.right.equalTo(-LocalUIConstants.sideInset)
            make.bottom.equalTo(-LocalUIConstants.buttonBottomInset)
        }
    }
}

// MARK: - Setup Targets:
extension MenuViewController {
    func setupTargets() {
        goToPayButton.addTarget(self, action: #selector(goToOrderScreen), for: .touchUpInside)
    }
}
