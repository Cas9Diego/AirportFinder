//
//  SliderScreenRouter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

class AirportsMapRouter: AirportsMapRouterProtocol {
    
    static func initModule(currentLocationData: CurrentLocation) -> UITabBarController {
        let initView = UIStoryboard(name: "AirPortFinderViews", bundle: nil).instantiateViewController(withIdentifier: "TabBarStoryBoard") as? TabBarViewController ?? TabBarViewController()
        let presenter: AirportsPresenterProtocol & AirportsMapInteractorOutProtocol = AirportsMapPresenter()
        let interactor: AirportsMapInteractorInProtocol = AirportsMapInteractor()
        let router: AirportsMapRouterProtocol = AirportsMapRouter()
        
        initView.presenter = presenter
        presenter.router = router
        presenter.view = initView
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.setMapAreaCoverage(withLocation: currentLocationData)
        
        return initView
    }
}


