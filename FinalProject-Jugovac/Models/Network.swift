//
//  Network.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation
import Alamofire

class Network{
    static let shared = Network()
    let jsonDecoder = JSONDecoder()
    
    private init(){ }
    
    //add working API Key
    let apiUrl = "https://api.spoonacular.com/recipes/random?number=10&apiKey=8d306fa0ef534c01ab50cfddabf26265"
    
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
    
    //add working API Key
    func getSingleRecipeInformationUrl(id: Int) -> String {
        return "https://api.spoonacular.com/recipes/\(id)/information?includeNutrition=false&apiKey=8d306fa0ef534c01ab50cfddabf26265"
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
    
}
