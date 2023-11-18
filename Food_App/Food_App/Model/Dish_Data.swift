import Foundation

// MARK: - CategoryData
struct Dish_Data: Codable {
    let meals: [Meal]?
}

// MARK: - Meal
struct Meal: Codable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
}
