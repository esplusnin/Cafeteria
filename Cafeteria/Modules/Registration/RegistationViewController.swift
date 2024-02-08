import UIKit

class RegistationViewController: UIViewController {

    // MARK: - Constants and Variables:
    private enum UILocalConstants {
        static let inputsStacksInset: CGFloat = 24
        static let buttonTopInset: CGFloat = 30
    }
    
    // MARK: - UI:
    private lazy var inputsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = UILocalConstants.inputsStacksInset
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
    }
}

// MARK: - CustomInputStackViewDelegate:
extension RegistationViewController: CustomInputStackViewDelegate {
    
}

// MARK: - Setup Views:
private extension RegistationViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Registration.registration

        [inputsStackView, registrationButton].forEach(view.addSubview)
        [emailStackView, passwordStackView, repeatPasswordStackView].forEach(inputsStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension RegistationViewController {
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
            make.top.equalTo(inputsStackView.snp.bottom).inset(-UILocalConstants.buttonTopInset)
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
}
