import Foundation

protocol MapConfiguratorProtocol: AnyObject {
    func configure(_ controller: MapViewController, with locationData: [LocationDTO]?)
}
