//
//  MapView.swift
//  NeonEV
//
//  Created by Shivoy Arora on 29/05/21.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    var coordinate: CLLocationCoordinate2D
    
    @AppStorage("MapView.zoom")
    private var zoom : Zoom = .medium
    
    enum Zoom: String, CaseIterable, Identifiable {
        case near = "Near"
        case medium = "Medium"
        case far = "Far"
        
        var id: Zoom{
            return self
        }
    }
    
    var delta: CLLocationDegrees {
        switch zoom {
        case .near: return 0.02
        case .medium: return 0.5
        case .far: return 1
        }
    }
    
    let places = [
        AnnotatedItem(coordinate: .init(latitude: 28.568238, longitude: 77.219666)),
        AnnotatedItem(coordinate: .init(latitude: 28.541995, longitude: 77.260583)),
        AnnotatedItem(coordinate: .init(latitude: 28.571189, longitude: 28.571189)),
        AnnotatedItem(coordinate: .init(latitude: 28.588991, longitude: 77.25324)),
        AnnotatedItem(coordinate: .init(latitude: 28.549427, longitude: 77.254636)),
        AnnotatedItem(coordinate: .init(latitude: 28.510291, longitude: 77.171653)),
        AnnotatedItem(coordinate: .init(latitude: 28.5224856, longitude: 77.0892318)),
        AnnotatedItem(coordinate: .init(latitude: 28.544785, longitude: 77.121449)),
        AnnotatedItem(coordinate: .init(latitude: 28.55476, longitude: 77.08831)),
        AnnotatedItem(coordinate: .init(latitude: 28.6453, longitude: 77.08831)),
        AnnotatedItem(coordinate: .init(latitude: 28.6471, longitude: 77.2247)),
        AnnotatedItem(coordinate: .init(latitude: 28.6573, longitude: 77.3024)),
        AnnotatedItem(coordinate: .init(latitude: 28.6553, longitude: 77.2979)),
        AnnotatedItem(coordinate: .init(latitude: 28.6553, longitude: 77.2979)),
        AnnotatedItem(coordinate: .init(latitude: 28.6215, longitude: 77.2935)),
        AnnotatedItem(coordinate: .init(latitude: 28.6605745, longitude: 77.1532531)),
        AnnotatedItem(coordinate: .init(latitude: 28.6965847, longitude: 77.1532531)),
        AnnotatedItem(coordinate: .init(latitude: 28.6107, longitude: 77.0765)),
        AnnotatedItem(coordinate: .init(latitude: 28.6277, longitude: 77.0765)),
        AnnotatedItem(coordinate: .init(latitude: 28.5969, longitude: 77.0033)),
        AnnotatedItem(coordinate: .init(latitude: 28.6375, longitude: 77.13)),
        AnnotatedItem(coordinate: .init(latitude: 28.6722, longitude: 77.13)),
        AnnotatedItem(coordinate: .init(latitude: 28.6551, longitude: 77.13)),
        AnnotatedItem(coordinate: .init(latitude: 28.616, longitude: 77.13)),
        AnnotatedItem(coordinate: .init(latitude: 28.4456, longitude: 77.0447)),
        AnnotatedItem(coordinate: .init(latitude: 28.7236, longitude: 77.1463)),
        AnnotatedItem(coordinate: .init(latitude: 28.6538, longitude: 77.0636)),
        AnnotatedItem(coordinate: .init(latitude: 28.6174, longitude: 77.0263)),
        AnnotatedItem(coordinate: .init(latitude: 28.6158, longitude: 77.0801)),
        AnnotatedItem(coordinate: .init(latitude: 28.6246, longitude: 77.0828)),
        AnnotatedItem(coordinate: .init(latitude: 28.6572, longitude: 77.0828)),
        AnnotatedItem(coordinate: .init(latitude: 28.7123, longitude: 77.2879)),
        AnnotatedItem(coordinate: .init(latitude: 28.4866, longitude: 77.0716)),
        AnnotatedItem(coordinate: .init(latitude: 28.55883366, longitude: 77.0716)),
        AnnotatedItem(coordinate: .init(latitude: 28.5360962, longitude: 77.2231022))
        
    ]
    
    var body: some View {
        
//        Map(coordinateRegion: .constant(region), interactionModes: .all, showsUserLocation: true)
        Map(coordinateRegion: .constant(region), interactionModes: .all, showsUserLocation: true, annotationItems: places, annotationContent: {
            MapMarker(coordinate: $0.coordinate, tint: .blue)
        })
        .onAppear {
            viewModel.checkIfLocationServicesIsEnabled()
        }
    }
    
    var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        )
    }
}



struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 28.54511, longitude: 77.27294))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}


final class MapViewModel: ObservableObject {
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            checkLocationAuthorization()
        }else {
            print("Turn on location manager")
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
        case .denied:
            print("denied")
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            break
        @unknown default:
            break
        }

    }
}
