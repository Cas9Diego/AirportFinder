//
//  SliderScreenInteractor
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import MapKit

class AirportsMapInteractor: AirportsMapInteractorInProtocol {

    weak var presenter: AirportsMapInteractorOutProtocol?
    var apiHeaders =  [
        "x-rapidapi-key": "f944eb3c64msh7a171e89b578ce6p110eb0jsn6747a28335c3",
        "x-rapidapi-host": "aviation-reference-data.p.rapidapi.com"
    ]
    
    func consultAvailableAirPorts(location: CurrentLocation?, isRetry: Bool) {
        let url = getURLWithCurrentlocation(location, isRetry: isRetry)
        guard let url = url else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = apiHeaders
        
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
                self?.presenter?.showFailedServiceAlert()
            } else {
                self?.decodeResponse(withData: data)
            }
        }).resume()
    }
    
    func getURLWithCurrentlocation(_ location: CurrentLocation?, isRetry: Bool) -> URL? {
        let radiosAdjust = isRetry ? 1: 1000
        let url = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(location?.latitude ?? 0.0)&lon=\(location?.longitude ?? 0.0)&radius=\(Int(location?.radius ?? 0)/1000)")
        
        return url
    }
    
    func decodeResponse(withData data: Data?) {
        guard let data = data else {   presenter?.showFailedServiceAlert()
            return}
        do {
          let airPortsArray = try JSONDecoder().decode([AirportsMapEntity].self, from: data)
            DispatchQueue.main.async {
                self.setMapPins(withAirPorts: airPortsArray)
            }
        } catch {
            print("ParsingError", error.localizedDescription)
            presenter?.didFinishFetchingWithData()
            DispatchQueue.main.async {
                self.presenter?.showFailedServiceAlert()
            }
        }
    }
    
    func setMapPins(withAirPorts airportsArray: [AirportsMapEntity] ) {
        var arrayOfAirPorts:[MKPointAnnotation] = []
        for airport in airportsArray {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude ?? 0.0, longitude: airport.longitude ?? 0.0)
            annotation.title = airport.name
            annotation.subtitle = airport.alpha2countryCode
            arrayOfAirPorts.append(annotation)
        }
        presenter?.didFinishFetchingWithData()
        presenter?.setAnnotationsOnMap(withAnnotations: arrayOfAirPorts)
    }

}
