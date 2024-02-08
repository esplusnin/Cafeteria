import Foundation

final class NetworkClient: NetworkClientInputProtocol {
    
    // MARK: - Dependencies:
    weak var output: NetworkClientOutputProtocol?
}
