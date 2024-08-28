//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import MapKit

class AirportsMapPresenter: AirportsMapPresenterProtocol {
    
    weak var view: AirportsMapViewProtocol?
    var interactor: AirportsMapInteractorInProtocol?
    var router: AirportsMapRouterProtocol?
    
    func setMapAreaCoverage(withLocation: CurrentLocation) {
        view?.setMapAreaCoverage(withLocation: withLocation)
    }
    
    func consultAvailableAirPorts(location: CurrentLocation?) {
        interactor?.consultAvailableAirPorts(location: location)
    }
    
}

extension AirportsMapPresenter: AirportsMapInteractorOutProtocol{
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        view?.setAnnotationsOnMap(withAnnotations: annotations)
    }
}
