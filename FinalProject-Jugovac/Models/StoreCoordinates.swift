//
//  StoreCoordinates.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation

class StoreCoordinates {
    
    static let shared = StoreCoordinates()
    private(set) var stores: [Stores] = []
    
    private init(){
        stores = [
            Stores(name: "Dolac",
              about: "Farmers market with home grown vegetables, fresh meat and fish.",
              latitude: 45.814628,
              longitude: 15.977321, url: "https://www.trznice-zg.hr/default.aspx?id=298"),
            Stores(name: "Spar SuperMarket",
              about: "Big market with a variety of produts with a reasonable price.",
              latitude: 45.813411,
              longitude: 15.986051, url: "https://www.spar.hr/lokacije/spar-supermarket-zagreb-10000-zagrebaka-3"),
            Stores(name: "Konzum SuperMarket",
               about: "Croatian big market with lots of traditional and other products.",
               latitude: 45.803842,
               longitude: 15.967079, url: "https://www.konzum.hr/"),
            Stores(name: "Zabac Food Outlet",
               about: "Small market with lots of produts with a really cheap price.",
               latitude: 45.815746,
               longitude: 15.976523, url: "https://www.facebook.com/zabacfoodoutlet/"),
            Stores(name: "Korean Store",
               about: "Small market with products coming from Asia.",
               latitude: 45.815268,
               longitude: 15.975922, url: "https://www.tripadvisor.com/Attraction_Review-g294454-d19269939-Reviews-Korean_Mart-Zagreb_Central_Croatia.html"),
            Stores(name: "Foodness",
               about: "Small store with products from America.",
               latitude: 45.807459,
               longitude: 15.988373, url: "https://www.facebook.com/foodness.shop/")
        ]
    }
    
    func getStores() -> [Stores]{
        stores
    }
    
}
