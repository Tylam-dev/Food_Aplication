import Foundation

protocol DishManagerDelegate4{
    func didUpdateDish4(dish: [Dish_Model])
    func didFailWithError4(error: Error)
}

struct Dish_Manager4 {
    let url: String = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    var delegate: DishManagerDelegate4?
    
    func fetchImageCategory(category: String){
        performRequest(with: url + category)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, respons, error in
                if error != nil{
                    self.delegate?.didFailWithError4(error: error!)
                }
                if let safeData = data {
                    if let dish = self.parseJSON(DishData: safeData){
                        self.delegate?.didUpdateDish4(dish: dish)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(DishData: Data) -> [Dish_Model]?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(Dish_Data.self, from: DishData)
            let dishes = decodeData.meals?.map{
                Dish_Model(name: $0.strMeal ?? "", imgUrl: $0.strMealThumb ?? "", id: $0.idMeal ?? "")
            }
            return dishes
        } catch{
            return nil
        }
    }
    
}
