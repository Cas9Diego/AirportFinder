//
//  SliderScreenRouter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

class SliderScreenRouter: SliderScreenRouterProtocol {
    
    static func initModule() -> SliderScreenViewProtocol {
        let initView: SliderScreenViewProtocol = UIStoryboard(name: K.srtStoryBoardName, bundle: nil).instantiateViewController(withIdentifier: V.srtSliderStoryboardIdentifier) as? SliderScreenViewController ?? SliderScreenViewController()
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
        fromViewController.navigationController?.pushViewController(TabBarRouter.initModule(currentLocationData: withLocationData), animated: true)
    }
    
    func sendToSettings(fromViewController: SliderScreenViewProtocol?) {
        let alert = UIAlertController(title: V.strLocationAlertTittle, message: V.strRequestLocation, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: V.strAcceptAction, style: .default) {_ in
            guard let settingsDirectory = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsDirectory) {
                UIApplication.shared.open(settingsDirectory)
            }
        }
        alert.addAction(acceptAction)
        fromViewController?.present(alert, animated: true)
    }
    
    func showErrorWhileGettingLocation(fromViewController: SliderScreenViewProtocol?) {
        let alert = UIAlertController(title: V.strLocationAlertTittle, message: V.strLocationAlertMessage, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: V.strAcceptAction, style: .default)
        alert.addAction(acceptAction)
        fromViewController?.present(alert, animated: true)
    }
}


