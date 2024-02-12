import UIKit

final class OrderViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: OrderViewControllerOutputProtocol?
    
    // MARK: - Classes:
    let configurator: OrderConfiguratorProtocol
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let collectionViewTopInset: CGFloat = 15
        static let collectionViewCellHeight: CGFloat = 71
        static let cellsSpacing: CGFloat = 6
        static let buttonHorizontalInset: CGFloat = 18
        static let buttonBottomInset: CGFloat = 32
    }
    
    // MARK: - UI:
    private lazy var orderCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.cafeterianCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var toPayButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Order.pay, for: .normal)
        button.titleLabel?.font = .largeTitleBold
        return button
    }()
    
    // MARK: - Lifecycle:
    init(configurator: OrderConfiguratorProtocol) {
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
        
        blockUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        output?.synchronizeOrder()
    }
    
    // MARK: - Public Methods:
    func setup(_ output: OrderViewControllerOutputProtocol) {
        self.output = output
    }
}

// MARK: - OrderViewControllerInputProtocol:
extension OrderViewController: OrderViewControllerInputProtocol {
    func orderDidUpdate() {
        if orderCollectionView.visibleCells.count == 0 {
            orderCollectionView.reloadData()
        }
        
        unblock()
    }
}

// MARK: - CustomCollectionViewDelegate:
extension OrderViewController: CustomCollectionViewCellDelegate {
    func change(value: Int, fromCell: CustomCollectionViewCell) {
        guard let indexPath = orderCollectionView.indexPath(for: fromCell),
              let id = output?.order?.products[indexPath.row].id else { return }
        
        output?.changeProductAmount(with: id, newValue: value)
    }
}

// MARK: - UICollectionViewDataSource:
extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output?.order?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.cafeterianCollectionViewCell,
                                                            for: indexPath) as? CustomCollectionViewCell,
              let product = output?.order?.products[indexPath.row]  else { return UICollectionViewCell() }
        
        cell.delegate = self
        cell.setup(state: .order)
        cell.setupCellModel(with: product.name, and: String(product.price), value: product.amount)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension OrderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: orderCollectionView.frame.width, height: LocalUIConstants.collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LocalUIConstants.cellsSpacing
    }
}

// MARK: - Setup Views:
private extension OrderViewController {
    func setupViews() {
        navigationItem.title = L10n.Order.title
        navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
        view.backgroundColor = Asset.Colors.backgroundWhite.color

        [orderCollectionView, toPayButton].forEach(view.addSubview)
    }
}

// MARK: - Setup Constraints:
private extension OrderViewController {
    func setupConstraints() {
        setupOrderCollectionViewConstraints()
        setupToPayButtonConstraints()
    }
    
    func setupOrderCollectionViewConstraints() {
        orderCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).inset(LocalUIConstants.collectionViewTopInset)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(toPayButton.snp.top).inset(-GlobalUIConstants.baseInset)
        }
    }
    
    func setupToPayButtonConstraints() {
        toPayButton.snp.makeConstraints { make in
            make.left.equalTo(LocalUIConstants.buttonHorizontalInset)
            make.right.equalTo(-LocalUIConstants.buttonHorizontalInset)
            make.bottom.equalTo(-LocalUIConstants.buttonBottomInset)
        }
    }
}
