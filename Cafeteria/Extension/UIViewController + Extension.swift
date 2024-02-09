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
        
        indicator.startAnimating()
    }
    
    func unblock() {
        var indicator: UIActivityIndicatorView? {
            view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
        }
        
        guard let indicator else { return }
        
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
}
