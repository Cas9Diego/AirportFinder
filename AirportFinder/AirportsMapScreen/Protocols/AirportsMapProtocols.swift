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
    func reloadTable()
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
    var didFinishFetchingPinsBool: Bool {get set}
    func didFinishFetchingPins()
    func setMapAreaCoverage(withLocation: CurrentLocation)
    func setAirportsListProperties(withInfo info: [MKPointAnnotation])
    func consultAvailableAirPorts(location: CurrentLocation?)
    func consultAvailableAirPorts(location: CurrentLocation?, locationUpdated: Bool)
}

protocol AirportsMapInteractorInProtocol: AnyObject {
    var presenter: AirportsMapInteractorOutProtocol? {get set}
    func consultAvailableAirPorts(location: CurrentLocation?, isRetry: Bool)
}

protocol AirportsMapInteractorOutProtocol: AnyObject {
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
    func showFailedServiceAlert() 
    func didFinishFetchingAnnotations()
    func reloadTable()
}

protocol ListViewProtocol: AnyObject {
    var annotationsInfo: [MKPointAnnotation] { get set }
    var presenter: AirportsPresenterProtocol?  { get set }
    var didfetchData: Bool  { get set }
    func reloadTable()
    func stopAnimating()
}
