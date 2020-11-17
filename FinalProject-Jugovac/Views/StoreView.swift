//
//  StoreView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI
import MapKit

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

    private(set) var model: Stores

    init(store: Stores) {
        model = store
    }
}

struct MapConfig {
    static let initialLocation = CLLocationCoordinate2D(latitude: 45.782722,
                                                        longitude: 15.981194)

    static let regionRadius: CLLocationDistance = 1000

    private init() {}
}

struct StoreView: UIViewRepresentable {
    
    struct MapState: Identifiable {
        let id = UUID()
        var store: Stores? = nil
        var error: Error? = nil
    }
    
    @Binding var data: [Stores]
    @Binding var mapState: MapState?

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> MKMapView {
        context.coordinator.requestUserLocation()
        context.coordinator.zoomToRegion()
        return context.coordinator.mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        context.coordinator.createAnnotations(data: data)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: StoreView
        var mapView: MKMapView
        var locationManager: CLLocationManager

        init(parent: StoreView) {
            self.parent = parent
            self.mapView = MKMapView()
            self.locationManager = CLLocationManager()
            
            super.init()
            
            self.mapView.delegate = self
        }
        
        func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
            print("Finished loading")
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
                        
            if annotation is MKUserLocation {
                return nil
            }
            
            guard let storeAnnotation = annotation as? StoreAnnotation else {
                return nil
            }
            
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: StoreAnnotation.reuseIdentifier) as? MKMarkerAnnotationView {
                
                annotationView.annotation = storeAnnotation
                annotationView.markerTintColor = UIColor.orange
                annotationView.glyphImage = UIImage(systemName: "person.fill")
//                annotationView.displayPriority = .required

                return annotationView
            }
            
            let annotationView = MKMarkerAnnotationView(annotation: storeAnnotation,
                                                        reuseIdentifier: StoreAnnotation.reuseIdentifier)
            annotationView.markerTintColor = UIColor.orange
            annotationView.glyphImage = UIImage(systemName: "person.fill")
            annotationView.canShowCallout = true
            
            let infoButton = UIButton(type: .infoLight)
            infoButton.tag = 0
            
            let directionsButton = UIButton(type: .infoLight)
            directionsButton.setImage(UIImage(systemName: "car"), for: .normal)
            directionsButton.tag = 1
            
            annotationView.leftCalloutAccessoryView = infoButton
            annotationView.rightCalloutAccessoryView = directionsButton
            
//            annotationView.displayPriority = .required
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            guard let storeAnnotation = view.annotation as? StoreAnnotation else {
                return
            }
            
            switch control.tag {
            case 0:
                parent.mapState = MapState(store: storeAnnotation.model)
            case 1:
                do {
                    try openDirections(for: storeAnnotation.model)
                } catch {
                    parent.mapState = MapState(error: error)
                }
            default:
                return
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
        
        func requestUserLocation() {
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                locationManager.requestWhenInUseAuthorization()
                // Show alert only if this is not the first time app is running
            }
            
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        }

        func zoomToRegion(center: CLLocationCoordinate2D = MapConfig.initialLocation,
                          regionRadius: CLLocationDistance = MapConfig.regionRadius) {

            let region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: regionRadius,
                                            longitudinalMeters: regionRadius)

            mapView.setRegion(region, animated: true)
        }

        func createAnnotations(data: [Stores]) {
            let existingAnnotations = mapView.annotations.filter({ !($0 is MKUserLocation) })
            mapView.removeAnnotations(existingAnnotations)
            mapView.addAnnotations(data.map(StoreAnnotation.init))
        }
    }
}



      // v1
//            for place in data {
//                let annotation = MKPointAnnotation()
//                annotation.coordinate = place.coordinate
//                annotation.title = place.name
//                annotation.subtitle = place.about
//                mapView.addAnnotation(annotation)
//            }

            // v2
//            for place in data {
//                let annotation = PlaceAnnotation(place: place)
//                mapView.addAnnotation(annotation)
//            }

            // v3
//            let annotations = data.map({ PlaceAnnotation(place: $0) })
//            mapView.addAnnotations(annotations)

            // v4
//            let annotations = data.map(PlaceAnnotation.init)
//            mapView.addAnnotations(annotations)

            // v5
//            mapView.addAnnotations(data.map({ PlaceAnnotation(place: $0) }))

