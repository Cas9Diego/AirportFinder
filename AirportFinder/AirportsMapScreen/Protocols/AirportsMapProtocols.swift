//
//  SliderScreensProtocols.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit

protocol AirportsMapRouterProtocol: AnyObject {
    static func initModule(currentLocationData: CurrentLocation) -> UITabBarController
}

protocol AirportsMapViewProtocol: UIViewController {
    var presenter: AirportsMapPresenterProtocol? {get set}
    func setMapAreaCoverage(withLocation location: CurrentLocation)
}

protocol MapViewProtocol {
    var location: CurrentLocation? {get set}
}

protocol AirportsMapPresenterProtocol: AnyObject {
    var router: AirportsMapRouterProtocol? {get set}
    var view: AirportsMapViewProtocol? {get set}
    var interactor: AirportsMapInteractorInProtocol? {get set}
    func setMapAreaCoverage(withLocation: CurrentLocation)

}

protocol AirportsMapInteractorInProtocol: AnyObject {
    var presenter: AirportsMapInteractorOutProtocol? {get set}
}

protocol AirportsMapInteractorOutProtocol: AnyObject {

}
