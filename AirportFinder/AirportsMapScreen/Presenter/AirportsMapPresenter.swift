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
    var didFinishFetchingPinsBool: Bool = false
    
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
        if didFinishFetchingPinsBool {
            didFinishFetchingPinsBool = false
            DispatchQueue.main.async {
                self.interactor?.consultAvailableAirPorts(location: location, isRetry: true)
            }
        }
    }
    
    func didFinishFetchingPins() {
        didFinishFetchingPinsBool = true
    }
}

// MARK: - Place pins airports on map
extension AirportsMapPresenter: AirportsMapInteractorOutProtocol{
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        view?.setAnnotationsOnMap(withAnnotations: annotations)
        setAirportsListProperties(withInfo: annotations)
    }
}

// MARK: - Handle additional response vars

extension AirportsMapPresenter {
    func showFailedServiceAlert() {
            view?.showFailedServiceAlert()
    }
    
    func didFinishFetchingAnnotations() {
        didFinishFetchingPins()
    }
    
    func reloadTable() {
        view?.reloadTable()
    }
}


