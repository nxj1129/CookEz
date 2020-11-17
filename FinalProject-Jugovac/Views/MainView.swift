//
//  MainPage.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            Text("CookEz").font(.title)

            List {
                Text("asdas")
                Text("asdas")
                Text("asdas")
            }
                
            Spacer()
            
            TabView {
                tabItem { Text("Stores") }.tag(1)
                tabItem { Text("Favorites") }.tag(2)
                tabItem { Text("Filters") }.tag(3)
                tabItem { Text("Add Recipe") }.tag(4)
            }

        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
