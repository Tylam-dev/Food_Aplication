//
//  Dish_Image_Controller.swift
//  Food_App
//
//  Created by Tyrone Vera on 17/11/23.
//

import Foundation

import Foundation

protocol DishPrepDelegate{
    func didUpdateDish(dish: Dish_Prep_Model)
    func didFailWithError(error: Error)
}

struct Dish_Prep_Manager {
    let url: String = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
    var delegate: DishPrepDelegate?
    
    func fetchPreparation(id: String){
        performRequest(with: url + id)
    }
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, respons, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                }
                if let safeData = data {
                    if let dish = self.parseJSON(DishData: safeData){
                        self.delegate?.didUpdateDish(dish: dish)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(DishData: Data) -> Dish_Prep_Model?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(Dish_Prep_Data.self, from: DishData)
            let video = (decodeData.meals?[0]["strYoutube"] ?? "") ?? ""
            var ingridientsArray: [String] = []
            var measuresArray: [String] = []
            let name = (decodeData.meals?[0]["strMeal"] ?? "") ?? ""
            
            if let ingredients = decodeData.meals?[0]{
                for ing in ingredients.keys{
                    if ing.hasPrefix("strIngredient"){
                        let ingPositionString = ing.split(separator: "strIngredient")
                    if let ingredient = ingredients[ing]{
                            if let ingre = ingredient {
                                if ingre != ""{
                                    ingridientsArray.append("\(ingPositionString[0])-\(ingre)")
                                }
                            }
                        }
                    }
                }
            }
            if let measures = decodeData.meals?[0]{
                for mes in measures.keys{
                    if mes.hasPrefix("strMeasure"){
                        let mesPositionString = mes.split(separator: "strMeasure")
                    if let measure = measures[mes]{
                            if let meas = measure {
                                if meas != "" && meas != " "{
                                    measuresArray.append("\(mesPositionString[0])-\(meas)")
                                }
                            }
                        }
                    }
                }
            }
            let instructions = (decodeData.meals?[0]["strInstructions"] ?? "") ?? ""
            return Dish_Prep_Model(videoUrl: video,ingredients: ingridientsArray,name: name, instructions: instructions, measures: measuresArray
            )
        } catch{
            return nil
        }
    }
    
}
