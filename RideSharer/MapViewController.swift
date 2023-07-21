//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global().async {
            self.checkLocationServices()

        }
        
        
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            showAlert(title: "Location services", textmsg: "You need to turn on your location")
        }
    }
    
    func checkLocationAuthorization() {
        
        switch locationManager.authorizationStatus {
            
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            
        case .denied: // Show alert telling users how to turn on permissions
            showAlert(title: "Location permission is needed ", textmsg: "You haven't provided access to your location")
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapView.showsUserLocation = true
            
        case .restricted: // Show an alert letting them know what’s up
            showAlert(title: "Location permission is needed ", textmsg: "You haven't provided access to your location")
            
        case .authorizedAlways:
            break
            
        default:
            break
        }
    }
    
    func showAlert(title: String, textmsg: String) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: textmsg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
