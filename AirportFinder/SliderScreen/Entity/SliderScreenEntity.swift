//
//  SliderScreenEntity.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import CoreLocation

struct SliderScreenEntity: Codable {

}

struct CurrentLocation {
    var latitude: CLLocationDistance
    var longitude: CLLocationDistance
    var center: CLLocation?
    var radius: CLLocationDistance
    
    init(latitude: CLLocationDistance, longitude: CLLocationDistance, center: CLLocation?, radius: CLLocationDistance) {
        self.latitude = latitude
        self.longitude = longitude
        self.center = center
        self.radius = radius
    }
}

struct V {
    static let srtSliderStoryboardIdentifier = "InitialStoryBoard"
    static let strLocationAlertTittle = "Algo falló"
    static let strLocationAlertMessage = "No pudimos recuperar tu ubicación"
    static let strRequestLocation = "Necesitamos acceso a tu ubicación"
    static let strAcceptAction = "Aceptar"
}
