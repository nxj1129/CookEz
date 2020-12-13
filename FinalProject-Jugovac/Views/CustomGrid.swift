//
//  CustomGrid.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 12/5/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomGrid : View {
    
    let recipe: Recipe
    let network: Network
    
    var body : some View{
        Text("")
        VStack(spacing: 18){
            
            ForEach(network.recipes){ items in
                
                HStack(spacing: 15){
                    
                    ForEach(items.self){j in
                        
                        VStack(spacing: 20){
                            
                            WebImage(url: self.recipe.imageUrl)
                                .resizable()
                                .cornerRadius(20)
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                            
                            HStack{
                                
                                Text(self.recipe.title)
                                
                                Spacer(minLength: 0)
                                
                            }.padding(.horizontal)
                            
                            HStack{
                                
                                Spacer()
                                
                                Text("\(self.recipe.readyInMinutes) min")
                                
                                Button(action: {
                                    
                                }) {
                                    
                                    Image("heart").renderingMode(.original)
                                }
                            }.padding([.horizontal,.bottom])
                            
                        }.background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
            
        }.padding()
    }
}
