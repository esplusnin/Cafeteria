import UIKit

final class AuthorizationViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: AuthorizationViewOutputProtocols?
    
    // MARK: - Classes:
    private let configurator = AuthorizationConfigurator()
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let inputsStacksInset: CGFloat = 24
        static let buttonTopInset: CGFloat = 30
    }
    
    // MARK: UI:
    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LocalUIConstants.inputsStacksInset
        return stackView
    }()
    
    private lazy var loginStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .login)
        return stackView
    }()
    
    private lazy var passwordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .password)
        return stackView
    }()
    
    private lazy var authorizationButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Authorization.enter, for: .normal)
        button.titleLabel?.font = .largeTitleBold
        return button
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
        configurator.configute(self)
    }
    
    // MARK: - Public Methods:
    func setup(_ output: AuthorizationViewOutputProtocols) {
        self.output = output
    }
    
    // MARK: - Objc methods:
    @objc private func authorize() {
        guard let login = loginStackView.inputTextField.text,
              let password = passwordStackView.inputTextField.text else { return }
        blockUI()
        output?.authorize(with: login, and: password)
    }
}

// MARK: - AuthorizationViewInputProtocol:
extension AuthorizationViewController: AuthorizationViewInputProtocol {
    func accountDidAuthorize() {
        unblock()
    }
}

// MARK: - CustomInputStackViewDelegate:
extension AuthorizationViewController: CustomInputStackViewDelegate {
    
}

// MARK: - Setup Views:
private extension AuthorizationViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Authorization.title
        addEndEditingGesture()
        
        [inputsStackView, authorizationButton].forEach(view.addSubview)
        [loginStackView, passwordStackView].forEach(inputsStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension AuthorizationViewController {
    func setupConstraints() {
        setupInputsStackViewConstraints()
        setupEnterButtonConstraints()
    }
    
    func setupInputsStackViewConstraints() {
        inputsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
    
    func setupEnterButtonConstraints() {
        authorizationButton.snp.makeConstraints { make in
            make.top.equalTo(inputsStackView.snp.bottom).inset(-LocalUIConstants.buttonTopInset)
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
}

// MARK: - Setup Targets:
private extension AuthorizationViewController {
    func setupTargets() {
        authorizationButton.addTarget(self, action: #selector(authorize), for: .touchUpInside)
    }
}
