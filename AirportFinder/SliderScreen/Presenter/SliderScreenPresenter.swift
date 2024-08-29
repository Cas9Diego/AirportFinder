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
    var radius: Int?
    
    func updateLocationValues(latitude: CLLocationDegrees, longitude: CLLocationDegrees, center: CLLocation?) {
        self.latitude = latitude
        self.longitude = longitude
        self.center = center
    }
    
    func didPressSearchButton(withSearchRadius radius: Int) {
        self.radius = radius
        interactor?.checkLocationPermissions(locationManager: view?.locationManager)
    }
    
    func showErrorWhileGettingLocation(fromViewController: SliderScreenViewProtocol?) {
        router?.showErrorWhileGettingLocation(fromViewController: fromViewController)
    }
}


extension SliderScreenPresenter: SliderScreenInteractorOutProtocol{
    func sendToSettings() {
        router?.sendToSettings(fromViewController: view)
    }
    
    func didGetLocation() {
        let locationData = CurrentLocation(latitude: latitude, longitude: longitude, center: center, radius: CLLocationDistance(radius ?? 20))
        router?.initMapView(withLocationData: locationData, fromViewController: view ?? SliderScreenViewController())
    }
}

