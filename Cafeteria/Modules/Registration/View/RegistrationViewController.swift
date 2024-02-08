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
    
    private lazy var emailStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .email)
        return stackView
    }()
    
    private lazy var passwordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .password)
        return stackView
    }()
    
    private lazy var repeatPasswordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .repeatPassword)
        return stackView
    }()
    
    private lazy var registrationButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Registration.registration, for: .normal)
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
//        guard let email = emailStackView.titleLabel.text,
//              let password = passwordStackView.titleLabel.text,
//              let repeatedPassword = repeatPasswordStackView.titleLabel.text else { return }
//        output?.createAccount(with: email, and: password, repeatedPassword: repeatedPassword)
        output?.createAccount(with: "", and: "", repeatedPassword: "")
    }
}

// MARK: - RegistrationViewProtocol:
extension RegistrationViewController: RegistrationViewInputProtocol {
    
}

// MARK: - CustomInputStackViewDelegate:
extension RegistrationViewController: CustomInputStackViewDelegate {
    
}

// MARK: - Setup Views:
private extension RegistrationViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Registration.registration

        [inputsStackView, registrationButton].forEach(view.addSubview)
        [emailStackView, passwordStackView, repeatPasswordStackView].forEach(inputsStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension RegistrationViewController {
    func setupConstraints() {
        setupInputsStackViewConstraints()
        setupRegistrationButton()
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
}

// MARK: - Setup Targets:
private extension RegistrationViewController {
    func setupTargets() {
        registrationButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
    }
}
