//
//  Network.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation
import Alamofire

class Network: ObservableObject{
    
    @Published var recipes = [Recipe]()
    @Published private(set) var favorites: [Recipe] = []
    @Published private(set) var recipeById: [Recipe] = []
    let jsonDecoder = JSONDecoder()
    
    init(){
        getAllRecipes(completion: { recipes, error in
            if let recipes = recipes {
                self.recipes = recipes
                print("\(recipes)")
            }
            
            if let error = error {
                print("Cannot get recipes because of: \(error)")
            }
        })
    }
    
    let apiUrl = "https://api.spoonacular.com/recipes/random?number=10&apiKey=474285c210694095996a21179005570a"
    
    func getAllRecipes(completion: @escaping ([Recipe]?, Error?) -> Void){
        AF.request(apiUrl, method:.get).responseJSON{ (response) in
            var recipeData: RecipeResponseData? = nil
            guard let responseData = response.data else{
                return print("Cannot get response data")
            }
            
            do{
                recipeData = try self.jsonDecoder.decode(RecipeResponseData.self, from: responseData)
                completion(recipeData?.recipes, nil)
            } catch let error{
                print("An error occured while getting the recipes: \(error)")
            }
        }
    }
    
    func getSingleRecipeInformationUrl(id: Int) -> String {
        return "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=474285c210694095996a21179005570a"
    }
    
    func getRecipeById(id: Int, completion: @escaping (Recipe?, Error?) -> Void){
        AF.request(getSingleRecipeInformationUrl(id: id), method: .get).responseJSON{ (response) in
            var recipeData: Recipe? = nil
            guard let responseData = response.data else{
                return print("Cannot get response data for recipe by id")
            }
            
            do{
                recipeData = try self.jsonDecoder.decode(Recipe.self, from: responseData)
                completion(recipeData, nil)
            } catch let error{
                print("An error occured while getting the recipes: \(error)")
                completion(nil, error)
            }
        }
    }
    
    func isFavorited(recipe: Recipe) -> Bool {
        return favorites.contains(where: { $0.id == recipe.id })
    }

    func toggleFavorite(recipe: Recipe) {
        if let index = favorites.firstIndex(where: { $0.id == recipe.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(recipe)
        }
    }

    func deleteFavorite(offset: IndexSet) {
        favorites.remove(atOffsets: offset)
    }
    
}
