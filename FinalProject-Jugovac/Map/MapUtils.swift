//
//  MapUtils.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 12/10/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class MapUtils{
    var locationManager: CLLocationManager
    
    init() {
        self.locationManager = CLLocationManager()
    }
    
    
    enum DirectionsError: Error, LocalizedError {
        case userLocationNotAvailable
        case url(message: String)
        
        var errorDescription: String? {
            localizedDescription
        }
        
        var localizedDescription: String {
            switch self {
            case .userLocationNotAvailable:
                return "User location is not available"
            case .url(let message):
                return message
            }
        }
    }
    
    func openDirections(for store: Stores) throws {
        guard let userLocation = locationManager.location else {
            throw DirectionsError.userLocationNotAvailable
        }
        
        let userLat = userLocation.coordinate.latitude
        let userLong = userLocation.coordinate.longitude
        
        let destinationLat = store.coordinates.latitude
        let destinationLong = store.coordinates.longitude
        
        let urlString = "https://maps.apple.com/?daddr=(\(destinationLat),\(destinationLong))&dirflg=d&saddr=(\(userLat),\(userLong))"
        
        guard let url = URL(string: urlString) else {
            throw DirectionsError.url(message: "Url not valid")
        }
        
        guard UIApplication.shared.canOpenURL(url) else {
            throw DirectionsError.url(message: "Cannot open url")
        }
        
        UIApplication.shared.open(url, options: [:])
    }
    
}
