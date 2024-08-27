//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import CoreLocation
import UIKit

class SliderScreenPresenter: SliderScreenPresenterProtocol {
    
    weak var view: SliderScreenViewProtocol?
    var interactor: SliderScreenInteractorInProtocol?
    var router: SliderScreenRouterProtocol?
    var latitude = 0.0
    var longitude = 0.0
    var center: CLLocation?
    
    func updateLocationValues(latitude: CLLocationDegrees, longitude: CLLocationDegrees, center: CLLocation?) {
        self.latitude = latitude
        self.longitude = longitude
        self.center = center
    }
    
    func didPressSearchButton(withSearchRadius radius: Int) {
        let locationData = CurrentLocation(latitude: latitude, longitude: longitude, center: center, radius: CLLocationDistance(radius))
        checkLocationPermissions { access in
            if access {
                router?.initMapView(withLocationData: locationData, fromViewController: view ?? SliderScreenViewController())
            } else {
                sendToSettings()
            }
        }
    }
    
    func checkLocationPermissions(completion: ((Bool) -> Void)) {
        let locationAccessStatus = view?.locationManager.authorizationStatus
        switch locationAccessStatus {
        case .notDetermined:
            completion(false)
        case .restricted, .denied:
            completion(false)
        case .authorizedAlways, .authorizedWhenInUse:
            completion(true)
        case .none:
            completion(false)
        case .some(_):
            completion(false)
        }
    }
    
    func sendToSettings() {
        let alert = UIAlertController(title: "Algo falló", message: "Necesitamos acceso a tu ubicación", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Aceptar", style: .default) {_ in
            guard let settingsDirectory = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsDirectory) {
                UIApplication.shared.open(settingsDirectory)
            }
        }
        alert.addAction(acceptAction)
        view?.present(alert, animated: true)
        
    }
}


extension SliderScreenPresenter: SliderScreenInteractorOutProtocol{

}

