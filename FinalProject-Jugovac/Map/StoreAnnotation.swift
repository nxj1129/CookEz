//
//  StoreAnnotation.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 12/10/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import MapKit

class StoreAnnotation: NSObject, MKAnnotation {
    static var reuseIdentifier: String {
        String(describing: self)
    }
    
    var title: String? {
        model.name
    }

    var subtitle: String? {
        model.about
    }

    var coordinate: CLLocationCoordinate2D {
        model.coordinates
    }
    
    var url: String{
        model.url
    }

    private(set) var model: Stores

    init(store: Stores) {
        model = store
    }
}
