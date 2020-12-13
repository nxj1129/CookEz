//
//  MainPage.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct MainView: View {

    @ObservedObject var network = Network()
    let session: Session
    
    var body: some View {
        NavigationView{
            TabView{
                RecipesView(network: network, session: session)
                    .tabItem{
                        Image(systemName: "book.fill")
                        Text("Recipes")
                }.tag(0)
                
                StoresMapView()
                    .tabItem{
                        Image(systemName: "cart.fill")
                        Text("Stores Map")
                }.tag(1)
                
                FavoritesView(network: network)
                    .tabItem{
                        Image(systemName: "heart.fill")
                        Text("Favorites")
                }.tag(2)
            }
            .onAppear(){
                UITabBar.appearance().barTintColor = UIColor.tabBarColor
            }
            .accentColor(.lightYellow)
            .shadow(color: .lightYellow, radius: 8, x: 0, y: 0)
        }
    }
}
