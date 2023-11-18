import Foundation

// MARK: - CategoryData
struct Category_Data: Codable {
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let strCategory: String?
}
