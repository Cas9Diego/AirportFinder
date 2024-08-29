//
//  SliderScreenInteractor
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation
import MapKit

class AirportsMapInteractor: TabBarInteractorInProtocol {

    weak var presenter: TabBarInteractorOutProtocol?
    var apiHeaders =  [
        "x-rapidapi-key": K.strApiKey,
        "x-rapidapi-host": K.strApiHost
    ]
    
    func consultAvailableAirPorts(location: CurrentLocation?) {
        let url = getURLWithCurrentlocation(location)
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
    
    func getURLWithCurrentlocation(_ location: CurrentLocation?) -> URL? {
        var url: URL?
        if let latitude = location?.latitude, let longitude = location?.longitude, let radius = location?.radius {
            url = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(latitude)&lon=\(longitude)&radius=\(Int(radius)/1000)")
        }
        return url
    }
    
    func decodeResponse(withData data: Data?) {
        guard let data = data else {   presenter?.showFailedServiceAlert()
            return}
        do {
          let airPortsArray = try JSONDecoder().decode([TabBarEntity].self, from: data)
            DispatchQueue.main.async { [weak self] in
                self?.setMapPins(withAirPorts: airPortsArray)
            }
        } catch {
            print("ParsingError", error.localizedDescription)
            presenter?.didFinishFetchingAnnotations()
            DispatchQueue.main.async { [weak self] in
                self?.presenter?.showFailedServiceAlert()
            }
        }
    }
    
    func setMapPins(withAirPorts airportsArray: [TabBarEntity] ) {
        var arrayOfAirPorts:[MKPointAnnotation] = []
        for airport in airportsArray {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude ?? 0.0, longitude: airport.longitude ?? 0.0)
            annotation.title = airport.name
            annotation.subtitle = airport.alpha2countryCode
            arrayOfAirPorts.append(annotation)
        }
        presenter?.didFinishFetchingAnnotations()
        presenter?.setAnnotationsInTabViewControllers(withAnnotations: arrayOfAirPorts)
    }

}
