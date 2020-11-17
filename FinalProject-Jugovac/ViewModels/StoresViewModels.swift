//
//  StoresViewModels.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation

class StoresViewModel: ObservableObject{
    @Published var data: [Stores] = []
    
    init() {
        data = StoreCoordinates.shared.stores
    }
}
