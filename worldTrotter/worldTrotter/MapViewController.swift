//
//  MapViewController.swift
//  worldTrotter
//
//  Created by Susan Kamies on 09/10/2017.
//  Copyright © 2017 Susan Kamies. All rights reserved.
//

import UIKit
import MapKit

class MapViewController :UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    //MARK: Global Declarations
    let enschedeCoordinate = CLLocationCoordinate2DMake(52.2215372, 6.8936619)
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var buttonLocation: UIButton!
    var buttonPins: UIButton!
    var index = 0
    
    //MARK: - Map setup
    let placeOfBirth = Pin(title: "Coendersstraat, Borne", coordinate: CLLocationCoordinate2D(latitude: 52.2895319, longitude: 6.75869009), info: "Start of my life")
    let here = Pin(title: "Rigelstraat, Enschede", coordinate: CLLocationCoordinate2D(latitude: 52.22853329, longitude: 6.85980840), info: "First house together with Berend")
    let newHouse = Pin(title: "Hulsmaatstraat, Enschede", coordinate: CLLocationCoordinate2D(latitude: 52.234369, longitude: 6.89993839), info: "First time as home owners")
    
    func resetRegion(){
        let region = MKCoordinateRegionMakeWithDistance(enschedeCoordinate, 50000, 50000)
        mapView.setRegion(region, animated: true)
    }
    
    override func loadView() {
        //Create a map view
        mapView = MKMapView()
        
        //Set it as the view of the view controller
        view = mapView
        
        //        Segmentcontrol toevoegen
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        //        Margins en constraints toevoegen
        let margins = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resetRegion()
        locationManager = CLLocationManager()
        
        // create button to find location
        buttonLocation = UIButton(frame: CGRect(x: 60, y: 550, width: 100, height: 50))
        buttonLocation.backgroundColor = .red
        buttonLocation.setTitle("Locatie?", for: .normal)
        buttonLocation.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(buttonLocation)
        
        // create button to display info pins
        buttonPins = UIButton(frame: CGRect(x: 180, y: 550, width: 100, height: 50))
        buttonPins.backgroundColor = .blue
        buttonPins.setTitle("Info pins", for: .normal)
        buttonPins.addTarget(self, action: #selector(buttonActionPins), for: .touchUpInside)
        view.addSubview(buttonPins)
        
        // User location
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //Important locations
      
        mapView.addAnnotations([placeOfBirth, here, newHouse])
        
    }
    
    //MARK: methods
    func buttonAction(sender: UIButton!){
        print("Button pressed")
        if let location = locationManager.location {
            mapView.showsUserLocation = true
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            mapView.setRegion(region, animated: true)
            buttonLocation.setTitle("Gevonden", for: .normal)
        }
    }
    
    func buttonActionPins(sender: UIButton!){
        print("Button pressed")
        let Pins = [placeOfBirth, here, newHouse]
        print("index:\(index)")
        
        if index <= 2 {
           let ac = UIAlertController(title: Pins[index].title, message: Pins[index].info, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            print("\(index)")
            index = index + 1
        }
        else {
            index = 0
        }
    }
    
    //MARK: Delegation methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Pin"
        if annotation is Pin {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annotationView!.rightCalloutAccessoryView = btn
            } else {
                annotationView!.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let pin = view.annotation as! Pin
        let placeName = pin.title
        let placeInfo = pin.info
        
        let ac = UIAlertController(title: placeName, message: placeInfo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

    
    func mapTypeChanged(_ segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex {
        case 0: mapView.mapType = .standard
        case 1: mapView.mapType = .hybrid
        case 2: mapView.mapType = .satellite
        default: break
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
}

