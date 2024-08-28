//
//  TabBarViewController.swift
//  AirportFinder
//
//  Created by Diego Castro on 27/08/24.
//

import UIKit
import CoreLocation
import MapKit

class TabBarViewController: UITabBarController, TabBarViewProtocol {
    
    var presenter: TabBarPresenterProtocol?
    weak var mapViewController: MapViewProtocol?
    weak var listViewController: ListViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setMapAreaCoverage(withLocation location: CurrentLocation) {
            if let mapViewController = self.viewControllers?.first as? MapViewProtocol {
                self.mapViewController = mapViewController
                mapViewController.location = location
                mapViewController.presenter = self.presenter
            }
    }
    
    func setAirportsListProperties(withInfo info: [MKPointAnnotation]) {
        DispatchQueue.main.async {
            if self.listViewController != nil {
                self.listViewController?.didfetchData = true
                self.listViewController?.annotationsInfo = info
                self.reloadTable()
            } else if let listViewController = self.viewControllers?[1] as? ListViewProtocol {
                self.listViewController = listViewController
                self.listViewController?.didfetchData = true
                listViewController.presenter = self.presenter
                self.listViewController?.annotationsInfo = info
                self.reloadTable()
            }
        }
    }
    
    func reloadTable() {
        listViewController?.reloadTable()
    }
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        mapViewController?.setAnnotationsOnMap(withAnnotations: annotations)
        presenter?.didFinishFetchingPins()
    }
    
    func showFailedServiceAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: K.strServiceAlertTittle, message: K.strServiceAlertMessage, preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: K.strAcceptAction, style: .default) { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(acceptAction)
            self.present(alert, animated: true)
        }
    }
}


