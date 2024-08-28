//
//  SliderScreensProtocols.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
import MapKit

protocol TabBarRouterProtocol: AnyObject {
    static func initModule(currentLocationData: CurrentLocation) -> UITabBarController
}

protocol TabBarViewProtocol: UIViewController {
    var presenter: TabBarPresenterProtocol? {get set}
    var listViewController: ListViewProtocol? {get set}
    func setMapAreaCoverage(withLocation location: CurrentLocation)
    func setAirportsListProperties(withInfo info: [MKPointAnnotation])
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
    func showFailedServiceAlert() 
    func reloadTable()
}

protocol MapViewProtocol: AnyObject {
    var location: CurrentLocation? {get set}
    var presenter: TabBarPresenterProtocol? {get set}
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation])
}

protocol TabBarPresenterProtocol: AnyObject {
    var router: TabBarRouterProtocol? {get set}
    var view: TabBarViewProtocol? {get set}
    var interactor: TabBarInteractorInProtocol? {get set}
    var didFinishFetchingPreviousPins: Bool {get set}
    func didFinishFetchingPins()
    func setMapAreaCoverage(withLocation: CurrentLocation)
    func setAirportsListProperties(withInfo info: [MKPointAnnotation])
    func consultAvailableAirPorts(location: CurrentLocation?)
    func consultAdditionalAirports(location: CurrentLocation?)
}

protocol TabBarInteractorInProtocol: AnyObject {
    var presenter: TabBarInteractorOutProtocol? {get set}
    func consultAvailableAirPorts(location: CurrentLocation?, isRetry: Bool)
}

protocol TabBarInteractorOutProtocol: AnyObject {
    func setAnnotationsInTabViewControllers(withAnnotations annotations: [MKPointAnnotation])
    func showFailedServiceAlert() 
    func didFinishFetchingAnnotations()
    func reloadTable()
}

protocol ListViewProtocol: AnyObject {
    var annotationsInfo: [MKPointAnnotation] { get set }
    var presenter: TabBarPresenterProtocol?  { get set }
    var didfetchData: Bool  { get set }
    func reloadTable()
    func stopAnimating()
}
