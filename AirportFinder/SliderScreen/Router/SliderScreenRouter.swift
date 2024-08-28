//
//  SliderScreenRouter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

class SliderScreenRouter: SliderScreenRouterProtocol {
    
    static func initModule() -> SliderScreenViewProtocol {
        let initView: SliderScreenViewProtocol = UIStoryboard(name: "AirPortFinderViews", bundle: nil).instantiateViewController(withIdentifier: "InitialStoryBoard") as? SliderScreenViewController ?? SliderScreenViewController()
        let presenter: SliderScreenPresenterProtocol & SliderScreenInteractorOutProtocol = SliderScreenPresenter()
        let interactor: SliderScreenInteractorInProtocol = SliderScreenInteractor()
        let router: SliderScreenRouterProtocol = SliderScreenRouter()
        
        initView.presenter = presenter
        presenter.router = router
        presenter.view = initView
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return initView
    }
    
    func initMapView(withLocationData: CurrentLocation, fromViewController: SliderScreenViewProtocol) {
        fromViewController.navigationController?.pushViewController(AirportsMapRouter.initModule(currentLocationData: withLocationData), animated: true)
    }
}


