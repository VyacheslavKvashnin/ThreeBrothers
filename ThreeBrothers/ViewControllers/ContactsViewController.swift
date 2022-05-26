//
//  ContactsViewController.swift
//  ThreeBrothers
//
//  Created by Вячеслав Квашнин on 19.05.2022.
//

import UIKit
import MapKit

final class ContactsViewController: UIViewController {
    
    let mapView = MKMapView()
    let initialLocation = CLLocationCoordinate2D(latitude: 55.159995, longitude: 61.402492)
    let breadPin = CLLocationCoordinate2D(latitude: 55.239284, longitude: 61.418294)
    let gorkyPin = CLLocationCoordinate2D(latitude: 55.163552, longitude: 61.434496)
    let brotherPin = CLLocationCoordinate2D(latitude: 55.178521, longitude: 61.359672)
    
    private let buttonCall: UIButton = {
        let button = UIButton.customButton()
        button.setTitle("Позвонить", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Контакты"
        
        view.addSubview(mapView)
        mapView.frame = view.bounds
        
        mapView.delegate = self
        
        mapView.centerToLocation(initialLocation)
        constrainingCamera()

        addCustomPin(coordinate: brotherPin, subtitle: "Братьев Кашириных 95/1")
        addCustomPin(coordinate: breadPin, subtitle: "Хлебозаводская 47/1")
        addCustomPin(coordinate: gorkyPin, subtitle: "Артиллерийская 117 к4")
        
//        view.addSubview(buttonCall)
        setButtonCallConstraints()
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
    
    private func setButtonCallConstraints() {
        view.addSubview(buttonCall)
        buttonCall.translatesAutoresizingMaskIntoConstraints = false
        buttonCall.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        buttonCall.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        buttonCall.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
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

extension ContactsViewController {
    private func addCustomPin(coordinate: CLLocationCoordinate2D, subtitle: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        pin.title = "3 Brata"
        pin.subtitle = subtitle
        mapView.addAnnotation(pin)
    }
}
