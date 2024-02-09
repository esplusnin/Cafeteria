import UIKit

final class CustomButton: UIButton {
    
    // MARK: - Constants and variables:
    private let height: CGFloat = 48
    
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
private extension CustomButton {
    func setupViews() {
        layer.cornerRadius = GlobalUIConstants.inputViewCornerRadius
        backgroundColor = Asset.Colors.backgroundDarkBrown.color
        titleLabel?.font = .mediumTitleBold
        setTitleColor(Asset.Colors.textSuperLightBrown.color, for: .normal)
    }
}

// MARK: - Setup Constraints:
private extension CustomButton {
    func setupConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(height)
        }
    }
}
