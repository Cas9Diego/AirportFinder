//
//  SliderScreen
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
import CoreLocation
import MapKit

class AirportsMapViewController: UIViewController, MapViewProtocol, MKMapViewDelegate {
    var presenter: AirportsMapPresenterProtocol?
    
    @IBOutlet var mapView: MKMapView!
    var location: CurrentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMap()
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.consultAvailableAirPorts(location: location)
    }
  
    func setupMap() {
        if let centerCoordinate = location?.center?.coordinate, let radius = location?.radius {
            let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: CLLocationDistance(radius), longitudinalMeters: CLLocationDistance(radius))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        for pin in annotations {
            mapView.addAnnotation(pin)
        }
        setupMap()
    }
}

// MARK: - Pins personalization
extension AirportsMapViewController {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil}
        let identifier = UUID().uuidString
        let pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        pinView.canShowCallout = true
        pinView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return pinView
    }
}
