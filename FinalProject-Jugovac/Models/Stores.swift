//
//  Stores.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation
import MapKit

struct Stores{
    let name: String
    let about: String
    let latitude: Double
    let longitude: Double
}

extension Stores{
    var coordinates: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
