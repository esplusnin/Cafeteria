import Foundation

struct ProductDTO {
    let id: Int
    var amount: Int
    
    mutating func changeValue(to value: Int) {
        amount = value
    }
}
