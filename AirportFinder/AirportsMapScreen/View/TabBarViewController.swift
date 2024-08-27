//
//  TabBarViewController.swift
//  AirportFinder
//
//  Created by Diego Castro on 27/08/24.
//

import UIKit
import CoreLocation

class TabBarViewController: UITabBarController, AirportsMapViewProtocol {
    
    var presenter: AirportsMapPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setMapAreaCoverage(withLocation location: CurrentLocation) {
        if var mapViewController = self.viewControllers?.first as? MapViewProtocol {
            mapViewController.location = location
            mapViewController.presenter = presenter
        }
    }

}

extension TabBarViewController: CLLocationManagerDelegate {
    
}
