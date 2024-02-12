import UIKit
import SnapKit
import Kingfisher

final class MenuCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: MenuCollectionViewCellDelegate?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let imageHeight: CGFloat = 137
        static let labelInset: CGFloat = 10
        static let buttonSide: CGFloat = 24
        static let buttonRightInset: CGFloat = -5
        static let fadeDuration: CGFloat = 0.5
    }
    
    private var product: Product?
    
    // MARK: - UI:
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = GlobalUIConstants.baseCornerRadius
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Asset.Colors.backgroundGray.color
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
        stepperView.delegate = self
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellUI()
        setupShadow()
    }
    
    // MARK: - Public Methods:
    func setupModel(_ product: Product) {
        self.product = product
    }
    
    // MARK: - Private Methods:
    private func setupCellUI() {
        guard let product,
              let url = URL(string: product.imageURL) else { return }
        
        titleLabel.text = product.name
        priceLabel.text = String(product.price) + L10n.Menu.rub

        let processor =  DownsamplingImageProcessor(size: productImageView.bounds.size)
        
        productImageView.kf.indicatorType = .activity
        productImageView.kf.setImage(with: url, options: [.processor(processor), .transition(.fade(LocalUIConstants.fadeDuration))])
    }
}

// MARK: - CustomStepperDelegate:
extension MenuCollectionViewCell: CustomStepperDelegate {
    func change(value: Int) {
        guard let id = product?.id else { return }
        delegate?.changeProductAmount(with: id, newValue: value)
    }
}

// MARK: - Setup Views:
extension MenuCollectionViewCell {
    func setupViews() {      
        backgroundColor = Asset.Colors.backgroundWhite.color
        
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
            make.height.equalTo(LocalUIConstants.imageHeight)
        }
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).inset(-LocalUIConstants.labelInset)
            make.left.equalTo(LocalUIConstants.labelInset)
            make.right.equalTo(-LocalUIConstants.labelInset)
        }
    }
    
    func setupPriceLabelConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.left.equalTo(LocalUIConstants.labelInset)
            make.bottom.equalTo(-LocalUIConstants.labelInset)
        }
    }
    
    func setupStepperViewConstraints() {
        stepperView.snp.makeConstraints { make in
            make.height.equalTo(LocalUIConstants.buttonSide)
            make.left.equalTo(snp.centerX)
            make.right.equalTo(LocalUIConstants.buttonRightInset)
            make.centerY.equalTo(priceLabel.snp.centerY)
        }
    }
}
