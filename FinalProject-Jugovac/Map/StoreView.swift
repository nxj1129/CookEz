//
//  StoreView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/3/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

struct StoreView: UIViewRepresentable {
    
    struct MapState: Identifiable {
        let id = UUID()
        var store: Stores? = nil
        var error: Error? = nil
    }
    
    @Binding var data: [Stores]
    @Binding var mapState: MapState?
    @Binding var mapType: MKMapType

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
        uiView.mapType = self.mapType
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: StoreView
        var mapView: MKMapView
        var mapUtils: MapUtils

        init(parent: StoreView) {
            self.parent = parent
            self.mapView = MKMapView()
            self.mapUtils = MapUtils()
            
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
            
            let annotationView = MKMarkerAnnotationView(annotation: storeAnnotation,
            reuseIdentifier: StoreAnnotation.reuseIdentifier)
            
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: StoreAnnotation.reuseIdentifier) as? MKMarkerAnnotationView {
                
                annotationView.annotation = storeAnnotation
                annotationView.markerTintColor = UIColor.green
                annotationView.glyphImage = UIImage(systemName: "cart.fill")

                return annotationView
            }
            
            annotationView.canShowCallout = true
            let urlButton = UIButton(type: .infoLight)
            urlButton.setImage(UIImage(systemName: "link.circle"), for: .normal)
            urlButton.tag = 0
            urlButton.tintColor = .black
            annotationView.leftCalloutAccessoryView = urlButton
            
            let directionsButton = UIButton(type: .infoLight)
            directionsButton.setImage(UIImage(systemName: "car"), for: .normal)
            directionsButton.tag = 1
            directionsButton.tintColor = .black
            annotationView.rightCalloutAccessoryView = directionsButton

            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            
            guard let storeAnnotation = view.annotation as? StoreAnnotation else {
                return
            }
            
            switch control.tag {
            case 0:
                if let url = URL(string: storeAnnotation.url){
                    UIApplication.shared.open(url)
                }
            case 1:
                do {
                    try mapUtils.openDirections(for: storeAnnotation.model)
                } catch {
                    parent.mapState = MapState(error: error)
                }
            default:
                return
            }
        }
        
        func requestUserLocation() {
            if CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
                mapUtils.locationManager.requestWhenInUseAuthorization()
            }
            
            mapUtils.locationManager.startUpdatingLocation()
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
