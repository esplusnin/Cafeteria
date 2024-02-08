import UIKit
import SnapKit

final class CustomInputStackView: UIStackView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomInputStackViewDelegate?
    
    // MARK: - Constants and Variables
    enum CustomInputStackViewState {
        case email
        case password
        case repeatPassword
    }
    
    private enum UILocalConstants {
        static let textFieldHeight: CGFloat = 47
        static let borderWidth: CGFloat = 2
        static let leftTextViewWidth: CGFloat = 18
        
        static let verticalSpacing: CGFloat = 7.5
        static let rightInset: CGFloat = 20
    }
    
    private var state: CustomInputStackViewState?
    
    // MARK: - UI:
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .bodyRegular
        label.textColor = Asset.Colors.textBrown.color
        return label
    }()
    
    private var inputTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = Asset.Colors.textBrown.color.cgColor
        textField.layer.borderWidth = UILocalConstants.borderWidth
        textField.isSecureTextEntry = true
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: UILocalConstants.leftTextViewWidth, height: UILocalConstants.textFieldHeight))
        textField.leftViewMode = .always
        textField.font = .bodyLarge
        textField.textColor = Asset.Colors.textLightBrown.color
        return textField
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(delegate: CustomInputStackViewDelegate, state: CustomInputStackViewState) {
        self.init()
        self.delegate = delegate
        self.state = state
    }
    
    // MARK: - Private Methods:
    private func setupStackView() {
        guard let state else { return }
        
        switch state {
        case .email:
            titleLabel.text = L10n.Registration.email
            inputTextField.isSecureTextEntry = false
            inputTextField.placeholder = L10n.Registration.emailPlaceholder
        case .password:
            titleLabel.text = L10n.Registration.password
            inputTextField.placeholder = L10n.Registration.passwordPlaceholder
        case .repeatPassword:
            titleLabel.text = L10n.Registration.repeatPassword
            inputTextField.placeholder = L10n.Registration.passwordPlaceholder
        }
    }
}

// MARK: - Setup Views:
private extension CustomInputStackView {
    func setupViews() {
        axis = .vertical
        backgroundColor = Asset.Colors.backgroundWhite.color
        
        [titleLabel, inputTextField].forEach(addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension CustomInputStackView {
    func setupConstraints() {
        setupInputTextFieldConstraints()
    }
    
    func setupInputTextFieldConstraints() {
        inputTextField.snp.makeConstraints { make in
            make.height.equalTo(UILocalConstants.textFieldHeight)
        }
    }
}
