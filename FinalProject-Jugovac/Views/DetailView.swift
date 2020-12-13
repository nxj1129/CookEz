//
//  DetailView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View{
    
    @ObservedObject var network: Network
    let recipe: Recipe
    
    @State private var isExtended = false
    @State private var isFavorited = false
    @State private var data: Recipe? = nil
    
    private var extendIcon: String {
        isExtended ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right"
    }
    
    private var favoriteButton: some View {
        Button(action: {
            self.network.toggleFavorite(recipe: self.recipe)
        }) {
            if network.isFavorited(recipe: recipe) {
                Image(systemName: "heart.fill")
                    .accentColor(.red)
                    .frame(width: 30, height: 30)
            } else {
                Image(systemName: "heart")
                    .frame(width: 30, height: 30)
                    .accentColor(.red)
            }
        }
    }
            
    func get() {
        network.getRecipeById(id: recipe.id, completion: {recipe, error in
            guard let recipe = recipe else{
                return
            }
            self.data = recipe
        })
    }
    
    var body: some View{
        ScrollView{
            VStack{
                HStack{
                    Text(data?.title ?? "")
                        .font(.title)

                    favoriteButton
                }

                WebImage(url: data?.imageUrl)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(30)
                    .frame(width: 350, height: 330)
                    .transition(.fade(duration: 0.5))
                
                HStack {
                    Text("Instructions")
                        .font(.custom("The Bugatten", size: 100))
                        .gradientText(colors: [.bg1, .bg2])
                        .offset(x:30, y:-20)
                    
                    Spacer().frame(width: 70)
                    
                    Button(action: {
                        self.isExtended.toggle()
                    }) {
                        Image(systemName: extendIcon)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .accentColor(.black)
                    }
                }.padding(.horizontal)
                
                Text(data?.instructions ?? "")
                    .font(.body)
                    .lineLimit(isExtended ? nil : 3)
                    .multilineTextAlignment(.leading)
                    
                Spacer()
                
            }
            .padding()
            .offset(y:-50)
        }
        .onAppear(perform: get)
    }
}
