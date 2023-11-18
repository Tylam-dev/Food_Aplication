//
//  ViewController.swift
//  Food_App
//
//  Created by Tyrone Vera on 16/11/23.
//

import UIKit

class FoodRecipesViewController: UIViewController {

    @IBOutlet var CategoriesCollection: [UILabel]!
    
    @IBOutlet var Img_Cat1_collection: [UIImageView]!
    
    @IBOutlet var DishesCat1Collection: [UILabel]!

    lazy var categoryManager = Category_Manager()
    lazy var dishManager = Dish_Manager()
    
    var categoriesAPI: [Category_Model] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryManager.delegate = self
        categoryManager.fetchFoodApi()
        dishManager.delegate = self
        // Do any additional setup after loading the view.
    }
}

extension FoodRecipesViewController: CategoryManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCategory(categories: [Category_Model]){
        categoriesAPI = categories
        DispatchQueue.main.async { [self] in
            for i in 0...4 {
                CategoriesCollection[i].text = categoriesAPI[i].category
                dishManager.fetchImageCategory(category: categoriesAPI[i].category)
            }
        }
    }
}
extension FoodRecipesViewController: DishManagerDelegate{
    func didUpdateDish(dish: [Dish_Model]) {
        DispatchQueue.main.async { [self] in
            for i in 0...4 {
                }
                
            }
        }
    }
}
