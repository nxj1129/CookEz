//
//  StoresMapView.swift
//  FinalProject-Jugovac
//
//  Created by Niko Jugovac on 11/28/20.
//  Copyright © 2020 Niko Jugovac. All rights reserved.
//
import SwiftUI
import MapKit

struct StoresMapView: View {
    @ObservedObject private var viewModel = StoresViewModel()
    @State private var mapState: StoreView.MapState? = nil
    
    @State private var selectedSegment = 0
    @State var mapType: [String: MKMapType] = [
        "Standard": .standard,
        "Satellite": .satellite,
        "Hybrid": .hybrid
    ]
    
    func getMapType(index: Int) -> (key: String, value: Binding<MKMapType>) {
        let indexItem = mapType.index(mapType.startIndex, offsetBy: index)
        return (mapType.keys[indexItem], $mapType.values[indexItem])
    }
    
    var body: some View {
        VStack {
            StoreView(data: $viewModel.data, mapState: $mapState, mapType: getMapType(index: self.selectedSegment).value)
                .edgesIgnoringSafeArea(.all)
                .overlay(Picker(selection: $selectedSegment, label: EmptyView()) {
                    ForEach(0 ..< mapType.count){ type in
                        Text(self.getMapType(index: type).key)
                    }
                }
                .padding(.bottom, 600)
                .pickerStyle(SegmentedPickerStyle()))
            
        }
    }
}
