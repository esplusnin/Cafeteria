import UIKit
import SnapKit
import YandexMapsMobile

final class MapViewController: UIViewController {
    
    // MARK: - Dependencies:
    private var output: MapViewControllerOutputProtocol?
    
    // MARK: - Classes:
    let configurator: MapConfiguratorProtocol
    
    // MARK: - Constants and Variables:
    private enum LocalUIConstants {
        static let placemarkTextSize: Float = 18
        static let baseZoom: Float = 9.5
        static let animationDuration: Float = 3
        static let xAnchor: CGFloat = 0.6
        static let yAnchor: CGFloat = 0.7
    }
    
    // MARK: - UI:
    private lazy var mapView: YMKMapView = {
        guard let mapView = YMKMapView(frame: .zero, vulkanPreferred: true) else { return YMKMapView() }
        return mapView
    }()
    
    // MARK: - Lifecycle:
    init(configurator: MapConfiguratorProtocol) {
        self.configurator = configurator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        output?.requestPlacemarks()
    }
    
    // MARK: - Public Methods:
    func setup(_ output: MapViewControllerOutputProtocol) {
        self.output = output
    }
    
    // MARK: - Private Methods
    private func moveTo(_ coordinate: YMKPoint) {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: coordinate,
                zoom: LocalUIConstants.baseZoom,
                azimuth: 0,
                tilt: 0), animation: YMKAnimation(type: .smooth, duration: LocalUIConstants.animationDuration))
    }
}

// MARK: - MapViewControllerInputProtocol:
extension MapViewController: MapViewControllerInputProtocol {
    func addPlacemarks(from locations: [Placemark]) {
        locations.forEach {
            let placemark: YMKPlacemarkMapObject = mapView.mapWindow.map.mapObjects.addPlacemark()
            placemark.geometry = YMKPoint(latitude: $0.latitude, longitude: $0.longitude)
            placemark.addTapListener(with: self)
            placemark.userData = $0.id
            
            let compositionIcon = placemark.useCompositeIcon()
            
            compositionIcon.setIconWithName(
                Asset.Images.coffeeCup.name,
                image: Asset.Images.coffeeCup.image, style: {
                    let style = YMKIconStyle()
                    style.anchor = NSValue(cgPoint: CGPoint(x: LocalUIConstants.xAnchor, y: LocalUIConstants.yAnchor))
                    return style
                }())
            
            compositionIcon.setIconWithName(
                Asset.Images.coffeCupBackground.name,
                image: Asset.Images.coffeCupBackground.image, style: {
                    let style = YMKIconStyle()
                    return style
                }())
            
            placemark.setTextWithText($0.name, style: {
                let style = YMKTextStyle()
                style.size = LocalUIConstants.placemarkTextSize
                style.color = Asset.Colors.textBrown.color
                style.placement = .bottom
                return style
            }())
        }
        
        if locations.count > 2 {
            let point = locations[1]
            moveTo(YMKPoint(latitude: point.latitude, longitude: point.longitude))
        }
    }
}

// MARK: - YMKMapObjectTapListener:
extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        guard let placemark = mapObject as? YMKPlacemarkMapObject,
              let id = placemark.userData as? Int else { return false }

        output?.goToMenu(with: id)
        return true
    }
}

// MARK: - Setup Views:
private extension MapViewController {
    func setupViews() {
        view.backgroundColor = Asset.Colors.backgroundWhite.color
        navigationItem.title = L10n.Map.title
        
        view.addSubview(mapView)
    }
}

// MARK: - Setup Constraints:
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
