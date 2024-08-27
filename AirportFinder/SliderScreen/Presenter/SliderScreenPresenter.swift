//
//  SliderScreenPresenter
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation

class SliderScreenPresenter: SliderScreenPresenterProtocol {
    
    weak var view: SliderScreenViewProtocol?
    var interactor: SliderScreenInteractorInProtocol?
    var router: SliderScreenRouterProtocol?
    
}

extension SliderScreenPresenter: SliderScreenInteractorOutProtocol{

}
