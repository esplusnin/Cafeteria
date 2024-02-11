import UIKit

final class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstraint {
        static let imageHeight: CGFloat = 137
        static let labelInset: CGFloat = 10
    }
    
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
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySmallBold
        label.textColor = Asset.Colors.textBrown.color
        return label
    }()
    
    private lazy var stepperView: CustomStepper = {
        let stepperView = CustomStepper()
        return stepperView
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
}

// MARK: - Setup Views:
extension MenuCollectionViewCell {
    func setupViews() {
        [productImageView, titleLabel, priceLabel, stepperView].forEach(addSubview)
    }
}

// MARK: - Setup COnstraints:
extension MenuCollectionViewCell {
    func setupConstraints() {
        setupProductImageViewConstraints()
        setupTitleLabelConstraints()
        setupPriceLabelConstraints()
        setupStepperViewConstraints()
    }
    
    func setupProductImageViewConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(LocalUIConstraint.imageHeight)
        }
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalTo(LocalUIConstraint.labelInset)
            make.right.equalTo(-LocalUIConstraint.labelInset)
        }
    }
    
    func setupPriceLabelConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(LocalUIConstraint.labelInset)
            make.left.bottom.equalTo(-LocalUIConstraint.labelInset)
            make.left.trailing.equalTo(stepperView.snp.left).inset(LocalUIConstraint.labelInset)
        }
    }
    
    func setupStepperViewConstraints() {
        stepperView.snp.makeConstraints { make in
            make.left.equalTo(snp.centerX)
            make.centerY.equalTo(priceLabel.snp.centerY)
            make.right.equalTo(-LocalUIConstraint.labelInset)
        }
    }
}
