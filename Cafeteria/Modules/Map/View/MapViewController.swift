import UIKit
import SnapKit
import YandexMapsMobile

final class MapViewController: UIViewController {
    
    // MARK: - UI
    private lazy var mapView: YMKMapView = {
        guard let mapView = YMKMapView(frame: .zero, vulkanPreferred: true) else { return YMKMapView() }
        return mapView
    }()
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: -
private extension MapViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Map.title
        
        view.addSubview(mapView)
    }
}

// MARK: -
private extension MapViewController {
    func setupConstraints() {
        setupMapViewConstraints()
    }
    
    func setupMapViewConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.bottom.right.equalToSuperview()
        }
    }
}
