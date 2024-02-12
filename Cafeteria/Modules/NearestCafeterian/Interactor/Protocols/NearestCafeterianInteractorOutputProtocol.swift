import Foundation

protocol NearestCafeterianInteractorOutputProtocol: AnyObject {
    func update(_ locations: [Location])
    func locationsDidNotUpdate()
}
