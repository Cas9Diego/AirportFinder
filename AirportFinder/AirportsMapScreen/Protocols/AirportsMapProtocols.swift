//
//  SliderScreensProtocols.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
import MapKit

protocol AirportsMapRouterProtocol: AnyObject {
    static func initModule(currentLocationData: CurrentLocation) -> UITabBarController
}

protocol AirportsMapViewProtocol: UIViewController {
    var presenter: AirportsPresenterProtocol? {get set}
    func setMapAreaCoverage(withLocation location: CurrentLocation)
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
}

protocol MapViewProtocol {
    var location: CurrentLocation? {get set}
    var presenter: AirportsPresenterProtocol? {get set}
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
}

protocol AirportsPresenterProtocol: AnyObject {
    var router: AirportsMapRouterProtocol? {get set}
    var view: AirportsMapViewProtocol? {get set}
    var interactor: AirportsMapInteractorInProtocol? {get set}
    func setMapAreaCoverage(withLocation: CurrentLocation)
    func consultAvailableAirPorts(location: CurrentLocation?)

}

protocol AirportsMapInteractorInProtocol: AnyObject {
    var presenter: AirportsMapInteractorOutProtocol? {get set}
    func consultAvailableAirPorts(location: CurrentLocation?)
}

protocol AirportsMapInteractorOutProtocol: AnyObject {
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
}
