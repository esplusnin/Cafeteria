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
    
    private lazy var emailStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .login)
        return stackView
    }()
    
    private lazy var passwordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .password)
        return stackView
    }()
    
    private lazy var enterButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Authorization.enter, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configurator.configute(self)
    }
    
    // MARK: - Public Methods:
    func setup(_ output: AuthorizationViewOutputProtocols) {
        self.output = output
    }
}

// MARK: - AuthorizationViewInputProtocol:
extension AuthorizationViewController: AuthorizationViewInputProtocol {
    
}

// MARK: - CustomInputStackViewDelegate:
extension AuthorizationViewController: CustomInputStackViewDelegate {
    
}

// MARK: - Setup Views:
private extension AuthorizationViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Authorization.title
        
        [inputsStackView, enterButton].forEach(view.addSubview)
        [emailStackView, passwordStackView].forEach(inputsStackView.addArrangedSubview)
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
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(inputsStackView.snp.bottom).inset(-LocalUIConstants.buttonTopInset)
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
}
