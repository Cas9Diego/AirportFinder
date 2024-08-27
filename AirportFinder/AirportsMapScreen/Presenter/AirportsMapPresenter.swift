//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation

class AirportsMapPresenter: AirportsMapPresenterProtocol {
    
    weak var view: AirportsMapViewProtocol?
    var interactor: AirportsMapInteractorInProtocol?
    var router: AirportsMapRouterProtocol?
    
    func setMapAreaCoverage(withLocation: CurrentLocation) {
        view?.setMapAreaCoverage(withLocation: withLocation)
    }
    
}

extension AirportsMapPresenter: AirportsMapInteractorOutProtocol{

}
