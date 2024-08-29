//
//  SliderScreenInteractor
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import CoreLocation

class SliderScreenInteractor: SliderScreenInteractorInProtocol {

    weak var presenter: SliderScreenInteractorOutProtocol?
    
    func checkLocationPermissions(locationManager: CLLocationManager?) {
        let locationAccessStatus = locationManager?.authorizationStatus
        switch locationAccessStatus {
        case .notDetermined, .restricted, .denied:
            presenter?.sendToSettings()
        case .authorizedWhenInUse, .authorizedAlways:
            presenter?.didGetLocation()
        case .none:
            presenter?.sendToSettings()
        case .some(_):
            presenter?.didGetLocation()
        }
    }
}
