import UIKit

final class NearestCafeterianViewController: UIViewController {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let collectionViewTopInset: CGFloat = 15
        static let collectionViewCellHeight: CGFloat = 71
        static let cellsSpacing: CGFloat = 6
        static let buttonHorizontalInset: CGFloat = 18
        static let buttonBottomInset: CGFloat = 32
    }
    
    // MARK: - UI:
    private lazy var cafeterianCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(CafeterinanCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.cafeterianCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var onMapButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.NearestCafeterian.onMap, for: .normal)
        button.titleLabel?.font = .largeTitleBold
        return button
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
    }
}

// MARK: - UICollectionViewDataSource:
extension NearestCafeterianViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.cafeterianCollectionViewCell, for: indexPath)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate:
extension NearestCafeterianViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: cafeterianCollectionView.frame.width, height: LocalUIConstants.collectionViewCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        LocalUIConstants.cellsSpacing
    }
}

// MARK: - Setup Views:
private extension NearestCafeterianViewController {
    func setupViews() {
        navigationItem.title = L10n.NearestCafeterian.title
        view.backgroundColor = Asset.Colors.backgroundWhite.color

        [cafeterianCollectionView, onMapButton].forEach(view.addSubview)
    }
}

// MARK: - Setup Constraints:
private extension NearestCafeterianViewController {
    func setupConstraints() {
        setupCafeterianCollectionViewConstraints()
        setupOnMapButtonConstraints()
    }
    
    func setupCafeterianCollectionViewConstraints() {
        cafeterianCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).inset(LocalUIConstants.collectionViewTopInset)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(onMapButton.snp.top).inset(-GlobalUIConstants.baseInset)
        }
    }
    
    func setupOnMapButtonConstraints() {
        onMapButton.snp.makeConstraints { make in
            make.left.equalTo(LocalUIConstants.buttonHorizontalInset)
            make.right.equalTo(-LocalUIConstants.buttonHorizontalInset)
            make.bottom.equalTo(-LocalUIConstants.buttonBottomInset)
        }
    }
}

// MARK: - Setup Targets:
private extension NearestCafeterianViewController {
    func setupTargets() {
        
    }
}
