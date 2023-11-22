//
//  ViewController.swift
//  Food_App
//
//  Created by Tyrone Vera on 16/11/23.
//  Created by Tyrone Vera on 16/11/23.
//

import UIKit
import Kingfisher

class FoodRecipesViewController: UIViewController {
    
    @IBOutlet var CategoriesCollection: [UILabel]!
    
    @IBOutlet var Img_Cat1_collection: [UIImageView]!
    
    @IBOutlet var DishesCat1Collection: [UILabel]!
    
    @IBOutlet var Img_Cat2_collection: [UIImageView]!
    
    @IBOutlet var DishesCat2Collection: [UILabel]!
    
    @IBOutlet var Img_Cat3_collection: [UIImageView]!
    
    @IBOutlet var DishesCat3Collection: [UILabel]!
    
    @IBOutlet var Img_Cat4_collection: [UIImageView]!
    
    @IBOutlet var DishesCat4Collection: [UILabel]!
    
    @IBOutlet var Img_Cat5_collection: [UIImageView]!
    
    @IBOutlet var DishesCat5Collection: [UILabel]!
    
    lazy var categoryManager = Category_Manager()
    lazy var dishManager1 = Dish_Manager1()
    lazy var dishManager2 = Dish_Manager2()
    lazy var dishManager3 = Dish_Manager3()
    lazy var dishManager4 = Dish_Manager4()
    lazy var dishManager5 = Dish_Manager5()
    lazy var dishPrepManager = Dish_Prep_Manager()
    var catArray: [String] = []
    var tag = "2"
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryManager.delegate = self
        dishManager1.delegate = self
        dishManager2.delegate = self
        dishManager3.delegate = self
        dishManager4.delegate = self
        dishManager5.delegate = self
        categoryManager.fetchFoodApi()
        
        // Do any additional setup after loading the view.
    }
    @objc func imageTapped(_ gesture: UITapGestureRecognizer) {
        if let tappedImageView = gesture.view as? UIImageView {
            // Obtén la etiqueta para identificar la imagen seleccionada
            tag = String(tappedImageView.tag)
            print(tag)
        }
        self.performSegue(withIdentifier: "GoToPrep", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToPrep"{
            let destination = segue.destination as! RecipeController
            destination.tag1 = tag
        }
    }
}


extension FoodRecipesViewController: CategoryManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCategory(categories: [Category_Model]){
        DispatchQueue.main.async { [self] in
            for i in 0...4 {
                CategoriesCollection[i].text = categories[i].category
                catArray.append(categories[i].category)
            }
            dishManager1.fetchImageCategory(category: catArray[0])
            dishManager2.fetchImageCategory(category: catArray[1])
            dishManager3.fetchImageCategory(category: catArray[2])
            dishManager4.fetchImageCategory(category: catArray[3])
            dishManager5.fetchImageCategory(category: catArray[4])
        }
    }
}

extension FoodRecipesViewController: DishManagerDelegate1{
    func didFailWithError1(error: Error) {
        print(error)
    }
    
    func didUpdateDish1(dish: [Dish_Model]) {
        
        for i in 0...3{
            DispatchQueue.main.async { [self] in
                let url = URL(string: dish[i].imgUrl)
                Img_Cat1_collection[i].kf.setImage(with: url)
                DishesCat1Collection[i].text = dish[i].name
                Img_Cat1_collection[i].tag = Int(dish[i].id)!
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                Img_Cat1_collection[i].addGestureRecognizer(tapGesture)
                Img_Cat1_collection[i].isUserInteractionEnabled = true
            }
        }
    }
}

extension FoodRecipesViewController: DishManagerDelegate2{
    func didFailWithError2(error: Error) {
        print(error)
    }
    
    func didUpdateDish2(dish: [Dish_Model]) {
        for i in 0...3{
            DispatchQueue.main.async { [self] in
                let url = URL(string: dish[i].imgUrl)
                Img_Cat2_collection[i].kf.setImage(with: url)
                DishesCat2Collection[i].text = dish[i].name
                Img_Cat2_collection[i].tag = Int(dish[i].id)!
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                Img_Cat2_collection[i].addGestureRecognizer(tapGesture)
                Img_Cat2_collection[i].isUserInteractionEnabled = true
            }
        }
    }
}

extension FoodRecipesViewController: DishManagerDelegate3{
    func didFailWithError3(error: Error) {
        print(error)
    }
    
    func didUpdateDish3(dish: [Dish_Model]) {
        for i in 0...3{
            DispatchQueue.main.async { [self] in
                let url = URL(string: dish[i].imgUrl)
                Img_Cat3_collection[i].kf.setImage(with: url)
                DishesCat3Collection[i].text = dish[i].name
                Img_Cat3_collection[i].tag = Int(dish[i].id)!
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                Img_Cat3_collection[i].addGestureRecognizer(tapGesture)
                Img_Cat3_collection[i].isUserInteractionEnabled = true
            }
        }
    }
}

extension FoodRecipesViewController: DishManagerDelegate4{
    func didFailWithError4(error: Error) {
        print(error)
    }
    
    func didUpdateDish4(dish: [Dish_Model]) {
        
        for i in 0...3{
            DispatchQueue.main.async { [self] in
                let url = URL(string: dish[i].imgUrl)
                Img_Cat4_collection[i].kf.setImage(with: url)
                DishesCat4Collection[i].text = dish[i].name
                Img_Cat4_collection[i].tag = Int(dish[i].id)!
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                Img_Cat4_collection[i].addGestureRecognizer(tapGesture)
                Img_Cat4_collection[i].isUserInteractionEnabled = true
            }
        }
    }
}

extension FoodRecipesViewController: DishManagerDelegate5{
    func didFailWithError5(error: Error) {
        print(error)
    }
    
    func didUpdateDish5(dish: [Dish_Model]) {
        for i in 0...3{
            DispatchQueue.main.async { [self] in
                let url = URL(string: dish[i].imgUrl)
                Img_Cat5_collection[i].kf.setImage(with: url)
                DishesCat5Collection[i].text = dish[i].name
                Img_Cat5_collection[i].tag = Int(dish[i].id)!
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
                Img_Cat5_collection[i].addGestureRecognizer(tapGesture)
                Img_Cat5_collection[i].isUserInteractionEnabled = true
            }
        }
    }
}
