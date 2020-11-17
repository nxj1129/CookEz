//
//  DetailView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI

struct DetailView: View{
    var body: some View{
        VStack{
            Text("Recipe name")
            
            Image(systemName: "location")
            .resizable()
                .frame(width: 200, height: 200)
            
            Spacer()
            
            Text("instructions")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
