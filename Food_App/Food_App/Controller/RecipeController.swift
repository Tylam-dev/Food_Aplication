//
//  RecipeController.swift
//  Food_App
//
//  Created by Tyrone Vera on 17/11/23.
//

import UIKit
import WebKit

class RecipeController: UIViewController {

    @IBOutlet weak var videoRepro: WKWebView!
    
    @IBOutlet weak var ingredientsList: UITextField!
    @IBOutlet weak var preparationText: UITextField!
    lazy var dishPrepManager = Dish_Prep_Manager()
    var tag1 = ""
    var videoUrl: String = ""
    var ingredients: [String] = []
    var name: String = ""
    var instructions: String = ""
    var measures: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        dishPrepManager.delegate = self
        dishPrepManager.fetchPreparation(id: tag1)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        
    }
    /*
    // MARK: - Navigation
wefwe
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RecipeController: DishPrepDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateDish(dish: Dish_Prep_Model) {
        videoUrl = dish.videoUrl
        ingredients = dish.ingredients
        name = dish.name
        instructions = dish.instructions
        measures = dish.measures
        DispatchQueue.main.async { [self] in
            let urlVideo = URL(string:videoUrl)
            let myRequest = URLRequest(url: urlVideo!)
            videoRepro.load(myRequest)
        }
    }
}
