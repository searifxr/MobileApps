//
//  FavoriteRecipies.swift
//  dinner
//
//  Created by Pothapragada, Krishna N on 9/25/25.
//

import Foundation

class FavoriteRecipies{
    var RecipeDictionary: [Recipes] = []
    
    func Append(_ recipeGiven: Recipes){
        RecipeDictionary.append(recipeGiven)
    }
    func Remove(_ recipeGiven: Recipes){
        RecipeDictionary.removeAll {$0 == recipeGiven}
    }
    func returnList() -> [Recipes] {
        return RecipeDictionary
    }
    func size() -> Int{
        return RecipeDictionary.count
    }
    
}
