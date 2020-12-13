//
//  Recipe.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation

struct Recipe: Codable, Identifiable{
    var id: Int
    var title: String
    var imageUrl: URL?
    var instructions: String
    var readyInMinutes: Int

    enum CodingKeys: String, CodingKey{
        case id = "id"
        case title = "title"
        case imageUrl = "image"
        case instructions = "instructions"
        case readyInMinutes = "readyInMinutes"
    }
}

struct RecipeResponseData: Codable{
    var recipes: [Recipe]
}
