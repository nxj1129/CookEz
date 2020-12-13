//
//  RecipesView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/19/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct RecipesView: View {
    
    @ObservedObject var network: Network
    let session: Session
    var body: some View {
        NavigationView{
                VStack{
                    TitleText(title: "Choose Recipe").offset(y:-70)
                    
                    List {
                        ForEach(network.recipes){ recipe in
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
                    .offset(y:-50)
                        
                        
                    
                }.padding()
                 .frame(height: UIScreen.main.bounds.height * 0.98)
                 .cornerRadius(30)
            
            .navigationBarTitle("")
            .navigationBarItems(trailing:
                CustomButton(session: session)
            )
        }
    }
}

struct CustomButton:View{
    let session: Session
    var body: some View{
        NavigationLink(destination: AuthView()){
            Text("Logout")
                .foregroundColor(.bg2)
                .font(.headline)
                .onTapGesture {
                    self.session.signOut()
            }
        }
    }
}

struct TitleText: View {
    var title: String
    var body: some View {
        HStack{
            Text(title)
                .font(.custom("The Bugatten", size: 130))
                .gradientText(colors: [.bg1, .bg2])
                .clipped()
                .shadow(color: Color.lightYellow, radius: 15, x: 0, y: 0)
                .padding(.bottom, 10)
        }
    }
}
