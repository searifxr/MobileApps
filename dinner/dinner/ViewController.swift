//
//  ViewController.swift
//  dinner
//
//  Created by Pothapragada, Krishna N on 9/19/25.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var GeneratedRecipe: UILabel!
    
    @IBOutlet weak var FavoriteButton: UIButton!
    
    let Recipe: RecipeList = RecipeList.sharedRecipe
    let FavoriteRecipe: FavoriteRecipies = FavoriteRecipies()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Recipe.GenerateARecipe()
        GeneratedRecipe.text = """
            Recipe Name:
            \(Recipe.grabRecipeName())
            
            Ingredients:
            \(Recipe.grabIngredients())
            
            Instructions:
            \(Recipe.grabInstructions())
            """
     }

    @IBAction func GenerateRecipe(_ sender: Any) {
        Recipe.GenerateARecipe()
        GeneratedRecipe.text = """
            Recipe Name:
            \(Recipe.grabRecipeName())
            
            Ingredients:
            \(Recipe.grabIngredients())
            
            Instructions:
            \(Recipe.grabInstructions())
            """
        if(!Recipe.grabFavorite()){
            FavoriteButton.backgroundColor = .black
        }
        
    }
    @IBAction func AddToFavorites(_ sender: Any) {
        if(Recipe.grabFavorite())
        {
            Recipe.setFavorite()
            FavoriteButton.backgroundColor = .black
            print("Deselected")
        }
        else{
            Recipe.setFavorite()
            FavoriteButton.backgroundColor = .yellow
            print("Selected")
        }
        
    }
    
}

