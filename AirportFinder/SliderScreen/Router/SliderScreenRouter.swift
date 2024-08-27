//
//  SliderScreenRouter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
/*
import GSSAInterceptor
import GSSAFunctionalUtilities
 */

class SliderScreenRouter: SliderScreenRouterProtocol {
    
    static func initModule() -> SliderScreenViewProtocol {
        let initView: SliderScreenViewProtocol = SliderScreenViewController()
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
}


