//
//  SliderScreensProtocols.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import UIKit
import CoreLocation

protocol SliderScreenRouterProtocol: AnyObject {
    static func initModule() -> SliderScreenViewProtocol
    func initMapView(withLocationData: CurrentLocation, fromViewController: SliderScreenViewProtocol)
}

protocol SliderScreenViewProtocol: UIViewController {
    var presenter: SliderScreenPresenterProtocol? {get set}
    var locationManager: CLLocationManager { get }
    func sendToSettings()
    func showErrorWhileGettingLocation()
}

protocol SliderScreenPresenterProtocol: AnyObject {
    var router: SliderScreenRouterProtocol? {get set}
    var view: SliderScreenViewProtocol? {get set}
    var interactor: SliderScreenInteractorInProtocol? {get set}
    func didPressSearchButton(withSearchRadius radius: Int)
    func updateLocationValues(latitude: CLLocationDegrees, longitude: CLLocationDegrees, center: CLLocation?)
}

protocol SliderScreenInteractorInProtocol: AnyObject {
    var presenter: SliderScreenInteractorOutProtocol? {get set}
    func checkLocationPermissions(locationManager: CLLocationManager?)
}

protocol SliderScreenInteractorOutProtocol: AnyObject {
    func sendToSettings()
    func didGetLocation()
}
