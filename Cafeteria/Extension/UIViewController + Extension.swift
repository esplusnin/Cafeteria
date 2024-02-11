import UIKit
import SnapKit

// MARK: - Block/Unblock UI:
extension UIViewController {
    func blockUI() {
        let indicator = UIActivityIndicatorView(style: .large)
        
        view.addSubview(indicator)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.isUserInteractionEnabled = false
        indicator.startAnimating()
    }
    
    func unblock() {
        var indicator: UIActivityIndicatorView? {
            view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
        }
        
        guard let indicator else { return }
        
        view.isUserInteractionEnabled = true
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}

extension UIViewController {
    func addEndEditingGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditingGesture))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func endEditingGesture() {
        view.endEditing(true)
    }
}
