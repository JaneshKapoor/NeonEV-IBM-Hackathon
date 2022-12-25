//
//  ContentView.swift
//  NeonEV
//
//  Created by Shivoy Arora on 10/09/22.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 28.54511, longitude: 77.27294))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
