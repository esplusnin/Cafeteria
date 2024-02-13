import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: RegistrationViewOutputProtocol?
    
    // MARK: - Classes:
    private let configurator = RegistrationConfigurator()
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let inputsStacksInset: CGFloat = 24
        static let buttonTopInset: CGFloat = 30
    }
    
    // MARK: - UI:
    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LocalUIConstants.inputsStacksInset
        return stackView
    }()
    
    private lazy var loginStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(state: .login)
        return stackView
    }()
    
    private lazy var passwordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(state: .password)
        return stackView
    }()
    
    private lazy var repeatPasswordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(state: .repeatPassword)
        return stackView
    }()
    
    private lazy var registrationButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Registration.registration, for: .normal)
        button.titleLabel?.font = .largeTitleBold
        return button
    }()
    
    private lazy var authorizationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(L10n.Registration.enterLogin, for: .normal)
        button.setTitleColor(Asset.Colors.textLightBrown.color, for: .normal)
        button.titleLabel?.font = .bodyMedium
        return button
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
        configurator.configure(self)
    }
    
    // MARK: - Public Methods:
    func setup(_ output: RegistrationViewOutputProtocol) {
        self.output = output
    }
    
    // MARK: - Objc Methods:
    @objc private func createAccount() {
        guard let login = loginStackView.inputTextField.text,
              let password = passwordStackView.inputTextField.text,
              let repeatedPassword = repeatPasswordStackView.inputTextField.text else { return }
        output?.createAccount(with: login, and: password, repeatedPassword: repeatedPassword)
        blockUI()
    }
    
    @objc private func authorization() {
        output?.goToAuthorizationScreen()
    }
}

// MARK: - RegistrationViewProtocol:
extension RegistrationViewController: RegistrationViewInputProtocol {
    func accountDidCreate() {
         unblock()
    }
    
    func accountDidNotCreate() {
        unblock()
        showBanner(subtitle: L10n.Warning.accountDidNotCreate)
    }
    
    func invalidEmailFormat() {
        unblock()
        loginStackView.changeInputState(isWrong: true)
        showBanner(subtitle: L10n.Warning.invalidEmail)
    }
    
    func invalidPasswordFormat() {
        unblock()
        passwordStackView.changeInputState(isWrong: true)
        repeatPasswordStackView.changeInputState(isWrong: true)
        showBanner(subtitle: L10n.Warning.invalidPassword)
    }
}

// MARK: - Setup Views:
private extension RegistrationViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Registration.registration
        addEndEditingGesture()
        
        [inputsStackView, registrationButton, authorizationButton].forEach(view.addSubview)
        [loginStackView, passwordStackView, repeatPasswordStackView].forEach(inputsStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension RegistrationViewController {
    func setupConstraints() {
        setupInputsStackViewConstraints()
        setupRegistrationButton()
        setupAuthorizationButtonConstraints()
    }
    
    func setupInputsStackViewConstraints() {
        inputsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
    
    func setupRegistrationButton() {
        registrationButton.snp.makeConstraints { make in
            make.top.equalTo(inputsStackView.snp.bottom).inset(-LocalUIConstants.buttonTopInset)
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
    
    func setupAuthorizationButtonConstraints() {
        authorizationButton.snp.makeConstraints { make in
            make.top.equalTo(registrationButton.snp.bottom).inset(-LocalUIConstants.buttonTopInset)
            make.centerX.equalToSuperview()
        }
    }
}

// MARK: - Setup Targets:
private extension RegistrationViewController {
    func setupTargets() {
        registrationButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
        authorizationButton.addTarget(self, action: #selector(authorization), for: .touchUpInside)
    }
}
