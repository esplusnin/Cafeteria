import Foundation

protocol MenuCollectionViewCellDelegate: AnyObject {
    func changeProductAmount(with id: Int, name: String, price: Int, newValue: Int)
}
