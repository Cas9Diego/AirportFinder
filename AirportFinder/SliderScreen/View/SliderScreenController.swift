//
//  SliderScreen
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
import CoreLocation

class SliderScreenViewController: UIViewController, SliderScreenViewProtocol {

    var presenter: SliderScreenPresenterProtocol?
    let locationManager = CLLocationManager()
    var latitude: CLLocationDegrees = 0.0
    var longitude: CLLocationDegrees = 0.0
    
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var radiusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
          locationManager.requestAlwaysAuthorization()
          locationManager.startUpdatingLocation()
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        radiusLabel.text = "\(Int(slider.value))"
    }
    
    @IBAction func didPressSearchButton(_ sender: UIButton) {
        locationManager.requestLocation()
        presenter?.didPressSearchButton(withSearchRadius: Int(slider.value))
    }
    
    
}

//Mark - Getting user coordinates
extension SliderScreenViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            presenter?.updateLocationValues(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, center: locations.last)
       }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        let alert = UIAlertController(title: "Algo falló", message: "No pudimos recueprar tu ubicación", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
    }
}
