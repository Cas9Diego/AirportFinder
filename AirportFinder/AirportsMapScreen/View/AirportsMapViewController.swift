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
    var presenter: TabBarPresenterProtocol?
    var didSetPins: Bool = false
    var currentMapInView: MKMapView?
    
    @IBOutlet var mapView: MKMapView!
    var location: CurrentLocation?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        setupMap()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
        setupActivityIndicator()
        activityIndicator.startAnimating()
    }
  
    func setupMap() {
        DispatchQueue.main.async { [weak self] in
            if let centerCoordinate = self?.location?.center?.coordinate, let radius = self?.location?.radius {
                let region = MKCoordinateRegion(center: centerCoordinate, latitudinalMeters: CLLocationDistance(radius), longitudinalMeters: CLLocationDistance(radius))
                self?.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        for pin in annotations {
            self.mapView.addAnnotation(pin)
        }
            self.activityIndicator.stopAnimating()
            if !self.didSetPins {
                self.didSetPins = true
                self.setupMap()
            }
            DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
                self?.didSetPins = true
                self?.presenter?.didFinishFetchingPins()
            }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        currentMapInView = mapView
        if presenter?.didFinishFetchingPreviousPins ?? true {
            let mapRegion = mapView.centerCoordinate
            let latitude = mapRegion.latitude
            let longitude = mapRegion.longitude
            let areaOnMap = CurrentLocation(latitude: latitude, longitude: longitude, center: CLLocation(latitude: latitude, longitude: longitude), radius: location?.radius ?? 0)
                self.presenter?.consultAdditionalAirports(location: areaOnMap)
        }
        mapView.userTrackingMode = .none
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
