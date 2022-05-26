//
//  ContactsViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import MapKit

final class ContactsViewController: UIViewController {
    
    let annotationItems: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 55.239284, longitude: 61.418294),
        CLLocationCoordinate2D(latitude: 55.163552, longitude: 61.434496)
        //        MyAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 55.178521, longitude: 61.359672))
    ]
    
    let mapView = MKMapView()
    let initialLocation = CLLocationCoordinate2D(latitude: 55.159995, longitude: 61.402492)
    let breadPin = CLLocationCoordinate2D(latitude: 55.239284, longitude: 61.418294)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Контакты"
        
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        mapView.delegate = self
        
        mapView.centerToLocation(initialLocation)
        constrainingCamera()
        addCustomPin()
    }
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = breadPin
        pin.title = "3 Brata"
        pin.subtitle = "Хлебозаводская 47/1"
        mapView.addAnnotation(pin)
    }
    
    private func constrainingCamera() {
        let chelyabinskCenter = CLLocation(latitude: 55.159995, longitude: 61.402492)
        let region = MKCoordinateRegion(
            center: chelyabinskCenter.coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000)
        mapView.setCameraBoundary(
            MKMapView.CameraBoundary(coordinateRegion: region),
            animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
}

private extension MKMapView {
    func centerToLocation(
        _ location: CLLocationCoordinate2D,
        regionRadius: CLLocationDistance = 10500
    ) {
        let coordinateRegion = MKCoordinateRegion(
            center: location,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension ContactsViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        annotationView?.image = UIImage(named: "burgerMini")
        return annotationView
    }
}
