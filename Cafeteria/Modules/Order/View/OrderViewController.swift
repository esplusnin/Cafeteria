import UIKit

final class OrderViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: OrderViewControllerOutputProtocol?
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Public Methods:
    func setup(_ output: OrderViewControllerOutputProtocol) {
        self.output = output
    }
}

// MARK: - OrderViewControllerInputProtocol:
extension OrderViewController: OrderViewControllerInputProtocol {
    
}

// MARK: - UICollectionViewDataSource:
extension OrderViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.cafeterianCollectionViewCell,
                                                            for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension OrderViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Setup Views:
private extension OrderViewController {
    func setupViews() {
        navigationItem.title = L10n.NearestCafeterian.title
        navigationItem.hidesBackButton = true
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
