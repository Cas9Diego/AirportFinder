//
//  SliderScreenEntity.swift
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation

struct AirportsMapEntity: Codable {
     let alpha2countryCode: String?
     let iataCode: String?
     let icaoCode: String?
     let latitude: Double?
     let longitude: Double?
     let name: String?
}

struct K {
    static let srtStoryBoardName = "AirPortFinderViews"
    static let strTabStoryboardIdentifier = "TabBarStoryBoard"
    static let strServiceAlertTittle = "Algo falló"
    static let strServiceAlertMessage = "Ocurrió un error inesperado, vuelve a intentarlo"
    static let strAcceptAction = "Aceptar"
    static let strApiKey = "f944eb3c64msh7a171e89b578ce6p110eb0jsn6747a28335c3"
    static let strApiHost = "aviation-reference-data.p.rapidapi.com"
    static let strCellIdentifier = "Cell"
}
