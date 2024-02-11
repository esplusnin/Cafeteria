import UIKit

final class MenuViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
}
