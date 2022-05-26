//
//  ContactsViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import MapKit
import CoreLocation



final class ContactsViewController: UIViewController, MKMapViewDelegate {
    
    let annotationItems: [CLLocationCoordinate2D] = [
CLLocationCoordinate2D(latitude: 55.239284, longitude: 61.418294),
CLLocationCoordinate2D(latitude: 55.163552, longitude: 61.434496)
//        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 55.178521, longitude: 61.359672))
    ]
    
    let map = MKMapView()
    let initialLocation = CLLocationCoordinate2D(latitude: 55.190524, longitude: 61.388399)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Контакты"
        
        view.addSubview(map)
        map.frame = view.bounds
        
        map.delegate = self
        
        map.setRegion(MKCoordinateRegion(
            center: initialLocation,
            span: MKCoordinateSpan(
                latitudeDelta: 0.1,
                longitudeDelta: 0.1)),
                      animated: false)
        
        addCustomPin()
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = initialLocation
        pin.title = "3 Brata"
        pin.subtitle = "Хлебозаводская 7В"
        map.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var annotationView = map.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(systemName: "mappin")
        return annotationView
    }
}
