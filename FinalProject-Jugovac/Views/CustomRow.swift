//
//  CustomRow.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/30/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomRow: View {
    let recipe: Recipe
    var body: some View {
        VStack{
            WebImage(url: recipe.imageUrl)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 200)
                .cornerRadius(30)
            HStack{
                Text(recipe.title)
                    .font(.headline)
                    .lineLimit(1)
                Spacer(minLength: 0)
                Text("\(recipe.readyInMinutes) min")
                    .font(.body)
                    .fontWeight(.bold)
            }
            .frame(width: 310)
            .padding()
        }
        .background(Color.lightYellow)
        .cornerRadius(30)
        .clipped()
        .shadow(color: Color.bg1, radius: 8, x: 0, y: 0)
        .padding(.bottom, 20)
    }
}
