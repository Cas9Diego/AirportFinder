//
//  TabBarViewController.swift
//  AirportFinder
//
//  Created by Diego Castro on 27/08/24.
//

import UIKit
import CoreLocation
import MapKit

class TabBarViewController: UITabBarController, AirportsMapViewProtocol {
    
    var presenter: AirportsPresenterProtocol?
    var mapViewController: MapViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setMapAreaCoverage(withLocation location: CurrentLocation) {
        if var mapViewController = self.viewControllers?.first as? MapViewProtocol {
            self.mapViewController = mapViewController
            mapViewController.location = location
            mapViewController.presenter = presenter
        }
    }
    
    func setAnnotationsOnMap(withAnnotations annotations: [MKPointAnnotation]) {
        mapViewController?.setAnnotationsOnMap(withAnnotations: annotations)
    }
}


