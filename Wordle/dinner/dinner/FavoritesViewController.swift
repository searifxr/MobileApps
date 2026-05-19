//
//  FavoritesViewController.swift
//  dinner
//
//  Created by Pothapragada, Krishna N on 9/25/25.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var Favorites: UILabel!
    let Recipe: RecipeList = RecipeList.sharedRecipe
    var FavoriteText = "Favorite Recipes: \n\n"
    var hasFavs = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 0..<Recipe.size(){
            if Recipe.isFavorite(i){
                FavoriteText += """
                \(Recipe.recipes[i].recipeName)
            
                \(Recipe.recipes[i].ingredients)
            
                \(Recipe.recipes[i].instructions)
            ______________________________
            """
            hasFavs = true
            }
            
        }
        
        if !hasFavs {
            FavoriteText += "No favorite recipes"
        }
        
        Favorites.text = FavoriteText
        print(FavoriteText)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
