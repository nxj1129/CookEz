//
//  Recipe.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation

struct Recipe: Codable{
    var id: Int
    var title: String
    var imageUrlString: String?
    var instructions: String
    
    var imageUrl: URL?{
        get{
            guard let url = URL(string: imageUrlString ?? "") else{
                return nil
            }
            return url
        }
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
        case imageUrlString = "image"
        case instructions = "instructions"
    }
}

struct RecipeResponseData: Codable{
    var recipes: [Recipe]
}
