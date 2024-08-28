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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
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
        presenter?.didPressSearchButton(withSearchRadius: Int(slider.value)*1000)
    }
    
    
}

// MARK: - Getting user coordinates
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

extension SliderScreenViewController {
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func showLoader() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
}
