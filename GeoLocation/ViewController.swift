//
//  ViewController.swift
//  GeoLocation
//
//  Created by Maliks on 12/08/2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    var map : MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        title = "Home"
        
        LocationManager.shared.getUserLocation { [weak self] location in
            
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                
                self.addMapPin(with: location)
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }

    func addMapPin(with location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        self.map.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.7, longitudeDelta: 0.7)), animated: true)
        self.map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }

}

