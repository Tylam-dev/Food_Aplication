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
    
    @IBOutlet weak var inrgedienteList: UITextView!
    
    @IBOutlet weak var descriptionText: UITextView!
    
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
        inrgedienteList.isEditable = false
        inrgedienteList.isScrollEnabled = true
        descriptionText.isEditable = false
        descriptionText.isScrollEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func ordenar(_ array: [String]) -> [String]{
        var arrayToWork = array
        let datosOrdenados = arrayToWork.sorted {
            guard let numero1 = Int($0.components(separatedBy: "-")[0]),
                  let numero2 = Int($1.components(separatedBy: "-")[0]) else {
                return false
            }
            return numero1 < numero2
        }
        
        let resultado = datosOrdenados.map {
            $0.components(separatedBy: "-").dropFirst().joined(separator: "-")
        }
        
        return resultado
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
            for i in 0..<ingredients.count{
                inrgedienteList.text += "\(ordenar(measures)[i]) \(ordenar(ingredients)[i]) \n"
            }
            descriptionText.text = instructions
        }
    }
}
