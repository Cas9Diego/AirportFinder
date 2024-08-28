//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import MapKit

class AirportsMapPresenter: AirportsPresenterProtocol {
    
    weak var view: TabBarViewProtocol?
    var interactor: AirportsMapInteractorInProtocol?
    var router: AirportsMapRouterProtocol?
    var didFinishFetching: Bool = false
    
    func setMapAreaCoverage(withLocation: CurrentLocation) {
        view?.setMapAreaCoverage(withLocation: withLocation)
    }
    
    func setAirportsListProperties(withInfo info: [MKPointAnnotation]) {
        view?.setAirportsListProperties(withInfo: info)
    }
    
    func consultAvailableAirPorts(location: CurrentLocation?) {
        interactor?.consultAvailableAirPorts(location: location, isRetry: false)
    }
    
    func consultAvailableAirPorts(location: CurrentLocation?, locationUpdated: Bool) {
        if didFinishFetching {
            didFinishFetching = false
            DispatchQueue.main.async {
                self.interactor?.consultAvailableAirPorts(location: location, isRetry: true)
            }
        }
    }
    
    func didFinishFetchingData() {
        didFinishFetching = true
    }
}

extension AirportsMapPresenter: AirportsMapInteractorOutProtocol{
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        view?.setAnnotationsOnMap(withAnnotations: annotations)
        setAirportsListProperties(withInfo: annotations)
    }
    
    func showFailedServiceAlert() {
            view?.showFailedServiceAlert()
    }
    
    func didFinishFetchingWithData() {
        didFinishFetchingData()
        
    }
    
    func reloadTable() {
        view?.reloadTable()
    }
}
