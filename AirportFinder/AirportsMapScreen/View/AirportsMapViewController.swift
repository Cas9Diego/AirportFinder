//
//  SliderScreen
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
import CoreLocation
import MapKit

class AirportsMapViewController: UIViewController, MapViewProtocol {
    var presenter: AirportsMapPresenterProtocol?
    
    @IBOutlet var mapView: MKMapView!
    var location: CurrentLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
    
}
