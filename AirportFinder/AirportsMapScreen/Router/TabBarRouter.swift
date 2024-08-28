//
//  SliderScreenRouter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

class TabBarRouter: TabBarRouterProtocol {
    
    static func initModule(currentLocationData: CurrentLocation) -> UITabBarController {
        let initView = UIStoryboard(name: K.srtStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: K.strTabStoryboardIdentifier) as? TabBarViewController ?? TabBarViewController()
        let presenter: TabBarPresenterProtocol & TabBarInteractorOutProtocol = TabBarPresenter()
        let interactor: TabBarInteractorInProtocol = AirportsMapInteractor()
        let router: TabBarRouterProtocol = TabBarRouter()
        
        initView.presenter = presenter
        presenter.router = router
        presenter.view = initView
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.setMapAreaCoverage(withLocation: currentLocationData)
        interactor.consultAvailableAirPorts(location: currentLocationData, isRetry: false)
        
        return initView
    }
}


