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
    
    private var location: Location? {
        didSet {
            setupCellUI()
        }
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
    
    private lazy var cafeterianTitleLabel: UILabel = {
       let label = UILabel()
        label.font = .largeTitleBold
        label.textColor = Asset.Colors.textBrown.color
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
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
    func setup(_ location: Location) {
        self.location = location
    }
        
    // MARK: - Private Methods:
    private func setupCellUI() {
        cafeterianTitleLabel.text = location?.name
        distanceLabel.text = location?.distance
    }
}

// MARK: - Setup Views:
private extension CustomCollectionViewCell {
    func setupViews() {
        contentBackgroundView.backgroundColor = Asset.Colors.backgroundLightBrown.color

        addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(titlesStackView)
        [cafeterianTitleLabel, distanceLabel].forEach(titlesStackView.addArrangedSubview)
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
