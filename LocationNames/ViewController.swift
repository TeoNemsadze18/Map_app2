//
//  ViewController.swift
//  LocationNames
//
//  Created by teona nemsadze on 11.07.23.
//

import CoreLocation
import MapKit
import UIKit

class ViewController: UIViewController {

    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(map)
        title = "Home"
        
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let strongSelf = self else {
                    return
                }
                strongSelf.adddMapPink(width: location)
            }
        }
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    func adddMapPink(width location: CLLocation) {
    let pin = MKPointAnnotation()
    pin.coordinate = location.coordinate
    map.setRegion(MKCoordinateRegion(
              center: location.coordinate,
              span: MKCoordinateSpan(
                latitudeDelta: 0.7,
                longitudeDelta: 0.7)),
                             animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location) { [weak self] locationName in
            self?.title = locationName
        }
    }
}













