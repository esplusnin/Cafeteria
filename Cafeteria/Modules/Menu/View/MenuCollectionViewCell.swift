import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI:
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyRegular
        label.textColor = Asset.Colors.textLightBrown.color
        return label
    }()
}
