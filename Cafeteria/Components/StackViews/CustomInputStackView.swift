import UIKit
import SnapKit

final class CustomInputStackView: UIStackView {
    
    // MARK: - Constants and Variables
    enum CustomInputStackViewState {
        case login
        case password
        case repeatPassword
    }
    
    private enum LocalUIConstants {
        static let labelHeight: CGFloat = 18
        static let textFieldHeight: CGFloat = 47
        static let borderWidth: CGFloat = 2
        static let leftTextViewWidth: CGFloat = 18
        
        static let verticalSpacing: CGFloat = 7.5
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
    
    private(set) var inputTextField: UITextField = {
        let textField = UITextField()
        textField.layer.borderColor = Asset.Colors.backgroundBrown.color.cgColor
        textField.layer.borderWidth = LocalUIConstants.borderWidth
        textField.layer.cornerRadius = GlobalUIConstants.inputViewCornerRadius
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: LocalUIConstants.leftTextViewWidth, height: LocalUIConstants.textFieldHeight))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.textContentType = .oneTimeCode
        textField.font = .bodyLarge
        textField.textColor = Asset.Colors.textLightBrown.color
        return textField
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(state: CustomInputStackViewState) {
        self.init()
        self.state = state
        setupStackView()
    }
    
    // MARK: - Public Methods:
    func changeInputState(isWrong: Bool) {
        UIView.animate(withDuration: GlobalUIConstants.baseAnimationDuration) {
            self.inputTextField.layer.borderColor = isWrong ? Asset.Colors.backgroundRed.color.cgColor : Asset.Colors.backgroundBrown.color.cgColor
        }
    }
    
    // MARK: - Private Methods:
    private func setupStackView() {
        guard let state else { return }
        inputTextField.delegate = self
        
        switch state {
        case .login:
            titleLabel.text = L10n.Registration.email
            inputTextField.isSecureTextEntry = false
            inputTextField.placeholder = L10n.Registration.emailPlaceholder
        case .password:
            titleLabel.text = L10n.Registration.password
            inputTextField.isSecureTextEntry = true
            inputTextField.placeholder = L10n.Registration.passwordPlaceholder
        case .repeatPassword:
            titleLabel.text = L10n.Registration.repeatPassword
            inputTextField.isSecureTextEntry = true
            inputTextField.placeholder = L10n.Registration.passwordPlaceholder
        }
    }
}

// MARK: - UITextFieldDelegate:
extension CustomInputStackView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeInputState(isWrong: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        changeInputState(isWrong: false)
    }
}

// MARK: - Setup Views:
private extension CustomInputStackView {
    func setupViews() {
        axis = .vertical
        spacing = LocalUIConstants.verticalSpacing
        distribution = .fillProportionally
        backgroundColor = Asset.Colors.backgroundWhite.color
        
        [titleLabel, inputTextField].forEach(addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension CustomInputStackView {
    func setupConstraints() {
        setupTitleLabelConstraints()
        setupInputTextFieldConstraints()
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(LocalUIConstants.labelHeight)
        }
    }
    
    func setupInputTextFieldConstraints() {
        inputTextField.snp.makeConstraints { make in
            make.height.equalTo(LocalUIConstants.textFieldHeight)
        }
    }
}
