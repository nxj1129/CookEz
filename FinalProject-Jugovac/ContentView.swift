//
//  ContentView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/2/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var session: Session
    
    func getUser() {
        session.listen()
    }
    
    var body: some View{
        Group{
            if (session.session != nil){
                MainView(session: session)
            }
            else{
                AuthView()
            }
        }.onAppear(perform: getUser)
        
    }
    
}
