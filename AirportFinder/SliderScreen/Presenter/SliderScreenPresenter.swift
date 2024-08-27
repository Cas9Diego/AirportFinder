//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import CoreLocation

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
        router?.initMapView(withLocationData: locationData, fromViewController: view ?? SliderScreenViewController())
    }
    
}

extension SliderScreenPresenter: SliderScreenInteractorOutProtocol{

}

