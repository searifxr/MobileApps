//
//  RecipeList.swift
//  dinner
//
//  Created by Pothapragada, Krishna N on 9/23/25.
//

import Foundation

struct Recipes: Equatable {
    public var recipeName: String
    public var ingredients: String
    public var instructions: String
    public var isFavorite: Bool
    
    init(recipeName: String, ingredients: String, instructions: String, isFavorite: Bool) {
        self.recipeName = recipeName
        self.ingredients = ingredients
        self.instructions = instructions
        self.isFavorite = isFavorite
    }
}

class RecipeList {
    static let sharedRecipe = RecipeList()
    private init(){}
    var RandomIndex = 0;
    var recipes = [
        Recipes(recipeName: "Spaghetti Marinara", ingredients: "Spaghetti pasta, marinara sauce, garlic, olive oil, parmesan cheese", instructions: "Cook pasta, heat sauce with garlic, combine and top with cheese", isFavorite: false),
        Recipes(recipeName: "Grilled Chicken", ingredients: "Chicken breast, salt, pepper, olive oil, lemon, herbs", instructions: "Season chicken, grill 6-8 minutes per side, rest and slice", isFavorite: false),
        Recipes(recipeName: "Beef Tacos", ingredients: "Ground beef, taco shells, onion, lettuce, cheese, tomatoes, spice", instructions: "Brown beef with spices, warm shells, assemble with toppings", isFavorite: false)
    ]
    
    func GenerateARecipe(){
        RandomIndex = Int.random(in: 0..<recipes.count)
    }
    
    func grabRecipeName() -> String{
        return recipes[RandomIndex].recipeName
    }
    
    func grabIngredients() -> String{
        return recipes[RandomIndex].ingredients
    }
    func grabInstructions() -> String{
        return recipes[RandomIndex].instructions
    }
    
    func grabRecipe() -> Recipes{
        return recipes[RandomIndex]
    }
    
    func setFavorite() {
        recipes[RandomIndex].isFavorite.toggle()
    }
    
    func grabFavorite() -> Bool {
        return recipes[RandomIndex].isFavorite
    }
    
    func size() -> Int{
        return recipes.count
    }
    func isFavorite(_ i: Int)-> Bool {
        return recipes[i].isFavorite
    }
}
