import UIKit

final class NearestCafeterianViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: NearestCafeterianViewOutputProtocol?
    
    // MARK: - Classes:
    private let configurator = NearestCafeterianConfigurator()
    
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
        configurator.configure(self)

        blockUI()
        output?.fetchLocations()
    }
    
    // MARK: - Public Methods:
    func setup(_ output: NearestCafeterianViewOutputProtocol) {
        self.output = output
    }
}

extension NearestCafeterianViewController: NearestCafeterianViewControllerInputProtocol {
    func updateLocationsList() {
        guard let newAmount = output?.locations.count else { return }
        cafeterianCollectionView.performBatchUpdates {
            for index in 0..<newAmount {
                cafeterianCollectionView.insertItems(at: [IndexPath(row: index, section: 0)])
            }
        }
        
        unblock()
    }
}

// MARK: - UICollectionViewDataSource:
extension NearestCafeterianViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output?.locations.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.Identifiers.cafeterianCollectionViewCell,
                                                            for: indexPath) as? CafeterinanCollectionViewCell,
              let location = output?.locations[indexPath.row] else { return UICollectionViewCell() }
                
        cell.setup(location)
        
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
        navigationItem.hidesBackButton = true
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
