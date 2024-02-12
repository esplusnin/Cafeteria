import UIKit

// MARK: - Setup Shadow:
extension UIView {
    func setupShadow() {
        layer.cornerRadius = GlobalUIConstants.baseCornerRadius
        
        layer.shadowColor = Asset.Colors.backgroundBlack.color.cgColor
        layer.shadowOpacity = GlobalUIConstants.shadowOpacity
        layer.shadowRadius = GlobalUIConstants.shadowRadius
        layer.shadowOffset = CGSize(width: 0, height: GlobalUIConstants.shadowHeight)
    }
}
