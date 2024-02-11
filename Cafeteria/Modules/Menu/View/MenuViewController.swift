import UIKit

final class MenuViewController: UIViewController {
    
    // MARK: - COnstants and Variables:
    private enum LocalUIConstants {
        static let buttonSideInset: CGFloat = 16
        static let buttonBottomInset: CGFloat = 32
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
}

// MARK: - UICollectionViewDataSource:
extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.menuCollectionViewCell, for: indexPath) as? MenuCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Setup Views:
extension MenuViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Menu.title
        
        [menuCollectionView, goToPayButton].forEach(view.addSubview)
    }
}

// MARK: - Setup Constraints::
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
            make.left.equalTo(LocalUIConstants.buttonSideInset)
            make.right.equalTo(-LocalUIConstants.buttonSideInset)
            make.bottom.equalTo(-LocalUIConstants.buttonBottomInset)
        }
    }
}
