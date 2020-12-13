//
//  MapConfig.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 12/10/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import MapKit

struct MapConfig {
    static let initialLocation = CLLocationCoordinate2D(latitude: 45.809315,
                                                        longitude: 15.981823)
    
    static let regionRadius: CLLocationDistance = 1500
    
    private init() {}
}
