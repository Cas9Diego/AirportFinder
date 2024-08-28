//
//  TabBarViewController.swift
//  AirportFinder
//
//  Created by Diego Castro on 27/08/24.
//

import UIKit
import CoreLocation
import MapKit

class TabBarViewController: UITabBarController, TabBatViewProtocol {
    
    var presenter: AirportsPresenterProtocol?
    var mapViewController: MapViewProtocol?
    var listViewController: ListViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setMapAreaCoverage(withLocation location: CurrentLocation) {
        DispatchQueue.main.async {
            if var mapViewController = self.viewControllers?.first as? MapViewProtocol {
                self.mapViewController = mapViewController
                mapViewController.location = location
                mapViewController.presenter = self.presenter
            }
        }
    }
    
    func setAirportsListProperties(withInfo info: [MKPointAnnotation]) {
        DispatchQueue.main.async {
            if let listViewController = self.viewControllers?[1] as? ListViewProtocol {
                self.listViewController = listViewController
                listViewController.presenter = self.presenter
                listViewController.annotationsInfo = info
                listViewController.stopAnimating()
            }
        }
    }
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        mapViewController?.setAnnotationsOnMap(withAnnotations: annotations)
    }
}


