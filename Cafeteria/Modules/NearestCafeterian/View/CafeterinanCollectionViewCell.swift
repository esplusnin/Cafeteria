import UIKit
import SnapKit

final class CafeterinanCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let stackViewSpacing: CGFloat = 6
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 14
        static let cornerRadius: CGFloat = 10
        
        static let shadowOpacity: Float = 0.25
        static let shadowRadius: CGFloat = 2
        static let shadowHeight: CGFloat = 2
    }
    
    // MARK: - UI:
    private lazy var contentBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var cafeterianTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .largeTitleBold
        label.textColor = Asset.Colors.textBrown.color
        label.text = "COFFE"
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
       let label = UILabel()
        label.font = .bodySmall
        label.textColor = Asset.Colors.textLightBrown.color
        label.text = "100 м от вас"
        return label
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    // MARK: - Private Methods:
    func addShadow() {
        contentBackgroundView.layer.cornerRadius = LocalUIConstants.cornerRadius
        contentBackgroundView.backgroundColor = Asset.Colors.backgroundLightBrown.color
        
        contentBackgroundView.layer.shadowColor = Asset.Colors.backgroundBlack.color.cgColor
        contentBackgroundView.layer.shadowOpacity = LocalUIConstants.shadowOpacity
        contentBackgroundView.layer.shadowRadius = LocalUIConstants.shadowRadius
        contentBackgroundView.layer.shadowOffset = CGSize(width: 0, height: LocalUIConstants.shadowHeight)
    }
}

// MARK: - Setup Views:
private extension CafeterinanCollectionViewCell {
    func setupViews() {
        addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(titlesStackView)
        [cafeterianTitleLabel, distanceLabel].forEach(titlesStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension CafeterinanCollectionViewCell {
    func setupConstraints() {
        setupTitlesStackViewConstraints()
        setupContentBackgroundViewConstraints()
    }
    
    func setupContentBackgroundViewConstraints() {
        contentBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(LocalUIConstants.horizontalInset)
            make.right.equalTo(-LocalUIConstants.horizontalInset)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupTitlesStackViewConstraints() {
        titlesStackView.snp.makeConstraints { make in
            make.top.equalTo(LocalUIConstants.verticalInset)
            make.left.equalTo(LocalUIConstants.horizontalInset)
            make.right.equalTo(-LocalUIConstants.horizontalInset)
        }
    }
}
