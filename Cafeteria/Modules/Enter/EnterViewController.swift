import UIKit

final class EnterViewController: UIViewController {
    
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
        let stackView = CustomInputStackView(delegate: self, state: .email)
        return stackView
    }()
    
    private lazy var passwordStackView: CustomInputStackView = {
        let stackView = CustomInputStackView(delegate: self, state: .password)
        return stackView
    }()
    
    private lazy var enterButton: CustomButton = {
        let button = CustomButton(type: .system)
        button.setTitle(L10n.Registration.registration, for: .normal)
        return button
    }()
}

// MARK: - CustomInputStackViewDelegate:
extension EnterViewController: CustomInputStackViewDelegate {
    
}

// MARK: - Setup Views:
private extension EnterViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Enter.title
        
        [inputsStackView, enterButton].forEach(view.addSubview)
        [emailStackView, passwordStackView].forEach(inputsStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
private extension EnterViewController {
    func setupConstraints() {
        setupInputsStackViewConstraints()
        setupEnterButtonConstraints()
    }
    
    func setupInputsStackViewConstraints() {
        inputsStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setupEnterButtonConstraints() {
        enterButton.snp.makeConstraints { make in
            make.top.equalTo(inputsStackView.snp.bottom).inset(LocalUIConstants.buttonTopInset)
            make.left.equalTo(GlobalUIConstants.baseInset)
            make.right.equalTo(-GlobalUIConstants.baseInset)
        }
    }
}
