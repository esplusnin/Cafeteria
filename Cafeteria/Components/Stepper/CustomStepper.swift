import UIKit
import SnapKit

final class CustomStepper: UIView {
    
    // MARK: - Dependencies:
    weak var delegate: CustomStepperDelegate?
    
    // MARK: - Constants and Variables:
    private var state: CustomCellState? {
        didSet {
            setupFonts()
        }
    }
    
    private var counter = 0 {
        didSet {
            countLabel.text = String(counter)
            delegate?.change(value: counter)
        }
    }
    
    // MARK: - UI:
    private lazy var stepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var dicrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Resources.Symbols.minus, for: .normal)
        return button
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySmall
        label.textColor = Asset.Colors.textBrown.color
        label.textAlignment = .center
        label.text = String(counter)
        return label
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Resources.Symbols.plus, for: .normal)
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
    
    // MARK: - Public Methods:
    func setup(state: CustomCellState) {
        self.state = state
    }
    
    func setupDefaultCounter(value: Int) {
        counter = value
    }
    
    // MARK: - Private Methods:
    func setupFonts() {
        switch state {
        case .menu:
            incrementButton.titleLabel?.font = .mediumTitleBold
            incrementButton.setTitleColor(Asset.Colors.textSuperLightBrown.color, for: .normal)
            dicrementButton.titleLabel?.font = .mediumTitleBold
            dicrementButton.setTitleColor(Asset.Colors.textSuperLightBrown.color, for: .normal)
        case .order:
            incrementButton.titleLabel?.font = .largeTitleBold
            incrementButton.setTitleColor(Asset.Colors.textBrown.color, for: .normal)
            dicrementButton.titleLabel?.font = .largeTitleBold
            dicrementButton.setTitleColor(Asset.Colors.textBrown.color, for: .normal)
            countLabel.font = .largeTitleBold
        default:
            break
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func increment() {
        counter += 1
    }
    
    @objc private func dicrement() {
        if counter >= 1 {
            counter -= 1
        }
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
        setupStepperStackViewConstratints()
    }
    
    func setupStepperStackViewConstratints() {
        stepperStackView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
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
