//
//  FavoritesView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var network = Network()
    var body: some View{
        ZStack{
            CustomGradient.mygradient
                .edgesIgnoringSafeArea([.top, .horizontal])
            VStack{
                TitleText(title: "Favorites")
                Spacer()
                NavigationView{
                    List {
                        ForEach(network.favorites){ recipe in
                            ZStack{
                                CustomRow(recipe: recipe)
                                NavigationLink(destination: DetailView(network: self.network, recipe: recipe)){
                                    EmptyView()
                                }
                            }
                            
                        }
                    }
                    .onAppear {
                        UITableView.appearance().separatorStyle = .none
                    }
                    .navigationBarTitle("")
                    .navigationBarHidden(true)
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.white)
            )
            .padding()
            .frame(height: UIScreen.main.bounds.height * 0.98)
            .cornerRadius(30)
            
        }
    }
}
