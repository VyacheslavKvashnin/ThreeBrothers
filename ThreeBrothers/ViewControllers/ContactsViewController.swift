//
//  ContactsViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import MapKit

struct MyAnnotationItem: Identifiable {
    let coordinate: CLLocationCoordinate2D
    let id = UUID()
}

final class ContactsViewController: UIViewController {
    
    let coordinateRegion: MKCoordinateRegion = {
        var newRegion = MKCoordinateRegion()
        newRegion.center.latitude = 55.178521
        newRegion.center.longitude = 61.359672
        newRegion.span.latitudeDelta = 0.2
        newRegion.span.longitudeDelta = 0.2
        return newRegion
    }()
    
    let annotationItems: [MyAnnotationItem] = [
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 55.239284, longitude: 61.418294)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 55.163552, longitude: 61.434496)),
        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 55.178521, longitude: 61.359672))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Контакты"
        
        let initialLocation = CLLocation(latitude: 55.178521, longitude: 61.359672)
        let mapView = MKMapView()
        mapView.centerLocation(initialLocation)
        view = mapView
    }
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}
