import UIKit
import SnapKit

enum CustomCellState {
    case menu
    case order
}

final class CustomCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: CustomCollectionViewCellDelegate?
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let minimumStepperViewWidth: CGFloat = 100
        static let stackViewSpacing: CGFloat = 6
        static let horizontalInset: CGFloat = 10
        static let verticalInset: CGFloat = 14
        static let cornerRadius: CGFloat = 10
    }
    
    private var state: CustomCellState? {
        didSet {
            if state == .order {
                setupStepperView()
            }
        }
    }
    
    // MARK: - UI:
    private lazy var contentBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titlesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = LocalUIConstants.stackViewSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .largeTitleBold
        label.textColor = Asset.Colors.textBrown.color
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .bodySmall
        label.textColor = Asset.Colors.textLightBrown.color
        return label
    }()
    
    private lazy var stepperView: CustomStepper = {
        let stepperView = CustomStepper()
        stepperView.delegate = self
        return stepperView
    }()
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentBackgroundView.setupShadow()
    }
    
    // MARK: - Public Methods:
    func setupCellModel(with title: String, and subtitle: String, value: Int?) {
        titleLabel.text = title
        subTitleLabel.text = state == .order ? subtitle + L10n.Menu.rub : subtitle
        stepperView.setupDefaultCounter(value: value ?? 0)
    }
    
    func setup(state: CustomCellState) {
        self.state = state
        stepperView.setup(state: state)
    }
}

// MARK: - CustomStepperDelegate:
extension CustomCollectionViewCell: CustomStepperDelegate {
    func change(value: Int) {
        delegate?.change(value: value, fromCell: self)
    }
}

// MARK: - Setup Views:
private extension CustomCollectionViewCell {
    func setupViews() {
        contentBackgroundView.backgroundColor = Asset.Colors.backgroundLightBrown.color
        
        addSubview(contentBackgroundView)
        contentBackgroundView.addSubview(titlesStackView)
        [titleLabel, subTitleLabel].forEach(titlesStackView.addArrangedSubview)
    }
    
    func setupStepperView() {
        addSubview(stepperView)
        setupStepperViewConstraints()
    }
}

// MARK: - Setup Constraints:
private extension CustomCollectionViewCell {
    func setupConstraints() {
        setupTitlesStackViewConstraints()
        setupContentBackgroundViewConstraints()
    }
    
    func setupContentBackgroundViewConstraints() {
        contentBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(LocalUIConstants.horizontalInset)
            make.right.equalTo(-LocalUIConstants.horizontalInset)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupTitlesStackViewConstraints() {
        titlesStackView.snp.makeConstraints { make in
            make.top.equalTo(LocalUIConstants.verticalInset)
            make.left.equalTo(LocalUIConstants.horizontalInset)
            make.right.equalTo(-LocalUIConstants.horizontalInset)
        }
    }
    
    func setupStepperViewConstraints() {
        stepperView.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(LocalUIConstants.minimumStepperViewWidth).priority(.high)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-LocalUIConstants.horizontalInset).priority(.high)
        }
        
        titlesStackView.snp.remakeConstraints { make in
            make.top.equalTo(LocalUIConstants.verticalInset)
            make.left.equalTo(LocalUIConstants.horizontalInset)
            make.right.lessThanOrEqualTo(stepperView.snp.left).inset(-LocalUIConstants.horizontalInset)
        }
    }
}
