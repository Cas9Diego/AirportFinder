//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import MapKit

class TabBarPresenter: TabBarPresenterProtocol {
    
    weak var view: TabBarViewProtocol?
    var interactor: TabBarInteractorInProtocol?
    var router: TabBarRouterProtocol?
    var didFinishFetchingPreviousPins: Bool = false
    
    func setMapAreaCoverage(withLocation: CurrentLocation) {
        view?.setMapAreaCoverage(withLocation: withLocation)
    }
    
    func setAirportsListProperties(withInfo info: [MKPointAnnotation]) {
        view?.setAirportsListProperties(withInfo: info)
    }
    
    func consultAvailableAirPorts(location: CurrentLocation?) {
        interactor?.consultAvailableAirPorts(location: location, isRetry: false)
    }
    
    func consultAdditionalAirports(location: CurrentLocation?) {
        if didFinishFetchingPreviousPins {
            didFinishFetchingPreviousPins = false
            DispatchQueue.main.async { [weak self] in
                self?.interactor?.consultAvailableAirPorts(location: location, isRetry: true)
            }
        }
    }
    
    func didFinishFetchingPins() {
        didFinishFetchingPreviousPins = true
    }
}

// MARK: - Place pins airports on map
extension TabBarPresenter: TabBarInteractorOutProtocol{
    func setAnnotationsInTabViewControllers(withAnnotations annotations: [MKPointAnnotation]) {
        view?.setAnnotationsOnMap(withAnnotations: annotations)
        setAirportsListProperties(withInfo: annotations)
    }
}

// MARK: - Handle additional response vars

extension TabBarPresenter {
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


