import Foundation

protocol MenuCollectionViewCellDelegate: AnyObject {
    func changeProductAmount(with id: Int, newValue: Int)
}
