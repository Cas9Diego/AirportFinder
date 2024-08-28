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
    var presenter: AirportsPresenterProtocol?
    
    @IBOutlet var mapView: MKMapView!
    var location: CurrentLocation?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMap()
        mapView.showsUserLocation = true
        setupActivityIndicator()
        activityIndicator.startAnimating()
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
        DispatchQueue.main.async {
        for pin in annotations {
            self.mapView.addAnnotation(pin)
        }
            self.activityIndicator.stopAnimating()
            self.setupMap()
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
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
