import Foundation

struct ProductDTO {
    let id: Int
    let name: String
    let price: Int
    var amount: Int
    
    mutating func changeValue(to value: Int) {
        amount = value
    }
}
