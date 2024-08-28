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

protocol TabBarViewProtocol: UIViewController {
    var presenter: AirportsPresenterProtocol? {get set}
    var listViewController: ListViewProtocol? {get set}
    func setMapAreaCoverage(withLocation location: CurrentLocation)
    func setAirportsListProperties(withInfo info: [MKPointAnnotation])
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
    func showFailedServiceAlert() 
}

protocol MapViewProtocol: AnyObject {
    var location: CurrentLocation? {get set}
    var presenter: AirportsPresenterProtocol? {get set}
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
}

protocol AirportsPresenterProtocol: AnyObject {
    var router: AirportsMapRouterProtocol? {get set}
    var view: TabBarViewProtocol? {get set}
    var interactor: AirportsMapInteractorInProtocol? {get set}
    func setMapAreaCoverage(withLocation: CurrentLocation)
    func setAirportsListProperties(withInfo info: [MKPointAnnotation])
    func consultAvailableAirPorts(location: CurrentLocation?)
}

protocol AirportsMapInteractorInProtocol: AnyObject {
    var presenter: AirportsMapInteractorOutProtocol? {get set}
    func consultAvailableAirPorts(location: CurrentLocation?)
}

protocol AirportsMapInteractorOutProtocol: AnyObject {
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
    func showFailedServiceAlert() 
}

protocol ListViewProtocol: AnyObject {
    var annotationsInfo: [MKPointAnnotation] { get set }
    var presenter: AirportsPresenterProtocol?  { get set }
    var didfetchData: Bool  { get set }
}
