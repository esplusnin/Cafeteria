import UIKit
import SnapKit

final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let stackViewSpacing: CGFloat = 6
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 14
        static let cornerRadius: CGFloat = 10
    }
    
    // MARK: - UI:
    private lazy var contentBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LocalUIConstants.stackViewSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .largeTitleBold
        label.textColor = Asset.Colors.textBrown.color
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .bodySmall
        label.textColor = Asset.Colors.textLightBrown.color
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
        contentBackgroundView.setupShadow()
    }
    
    // MARK: - Public Methods:
    func setupCellModel(with title: String, and subtitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subtitle
    }
}

// MARK: - Setup Views:
private extension CustomCollectionViewCell {
    func setupViews() {
        contentBackgroundView.backgroundColor = Asset.Colors.backgroundLightBrown.color

        addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(titlesStackView)
        [titleLabel, subTitleLabel].forEach(titlesStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension CustomCollectionViewCell {
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
