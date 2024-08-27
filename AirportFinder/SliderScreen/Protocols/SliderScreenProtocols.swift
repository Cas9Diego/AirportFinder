//
//  SliderScreensProtocols.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

protocol SliderScreenRouterProtocol: AnyObject {
    static func initModule() -> SliderScreenViewProtocol
}

protocol SliderScreenViewProtocol: UIViewController {
    var presenter: SliderScreenPresenterProtocol? {get set}

}

protocol SliderScreenPresenterProtocol: AnyObject {
    var router: SliderScreenRouterProtocol? {get set}
    var view: SliderScreenViewProtocol? {get set}
    var interactor: SliderScreenInteractorInProtocol? {get set}

}

protocol SliderScreenInteractorInProtocol: AnyObject {
    var presenter: SliderScreenInteractorOutProtocol? {get set}
}

protocol SliderScreenInteractorOutProtocol: AnyObject {

}
