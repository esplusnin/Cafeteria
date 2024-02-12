import Foundation

protocol CustomCollectionViewCellDelegate: AnyObject {
    func change(value: Int, fromCell: CustomCollectionViewCell)
}
