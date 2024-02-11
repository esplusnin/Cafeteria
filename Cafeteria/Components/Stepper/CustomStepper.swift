import UIKit
import SnapKit

final class CustomStepper: UIView {
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstraint {
        static let spacing: CGFloat = 9
        static let buttonSide: CGFloat = 24
    }
    
    private var counter = 0 {
        didSet {
            countLabel.text = String(counter)
        }
    }
    
    // MARK: - UI:
    private lazy var stepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = LocalUIConstraint.spacing
        return stackView
    }()
    
    private lazy var dicrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Resources.Symbols.minus, for: .normal)
        return button
    }()
    
    private(set) lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySmall
        label.text = String(counter)
        return label
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Resources.Symbols.plus, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Objc Methods:
    @objc private func increment() {
        counter += 1
    }
    
    @objc private func dicrement() {
        counter -= 1
    }
}

// MARK: - Setup Views:
extension CustomStepper {
    func setupViews() {
        addSubview(stepperStackView)
        [dicrementButton, countLabel, incrementButton].forEach(stepperStackView.addArrangedSubview)
    }
}

// MARK: - Setup Constraints:
extension CustomStepper {
    func setupConstraints() {
        setupDecrementButtonConstraints()
        setupIncrementButtonConstraints()
    }
    
    func setupDecrementButtonConstraints() {
        dicrementButton.snp.makeConstraints { make in
            make.height.width.equalTo(LocalUIConstraint.buttonSide)
        }
    }
    
    func setupIncrementButtonConstraints() {
        incrementButton.snp.makeConstraints { make in
            make.height.width.equalTo(LocalUIConstraint.buttonSide)
        }
    }
}

// MARK: - Setup Targets:
extension CustomStepper {
    func setupTargets() {
        dicrementButton.addTarget(self, action: #selector(dicrement), for: .touchUpInside)
        incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
    }
}