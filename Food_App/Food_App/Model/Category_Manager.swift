import Foundation

protocol CategoryManagerDelegate{
    func didUpdateCategory(categories: [Category_Model])
    func didFailWithError(error: Error)
}

struct Category_Manager {
    let URLstring: String = "https://www.themealdb.com/api/json/v1/1/categories.php"
    var delegate: CategoryManagerDelegate?
    
    func fetchFoodApi(){
        performRequest(with: URLstring)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, respons, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let category = self.parseJSON(categoryData: safeData){
                        self.delegate?.didUpdateCategory(categories: category)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(categoryData: Data) -> [Category_Model]?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(Category_Data.self, from: categoryData)
            let categories = decodeData.categories?.map{
                Category_Model(category: $0.strCategory ?? "")
            }
            return categories
        } catch{
            return nil
        }
    }
    
}
