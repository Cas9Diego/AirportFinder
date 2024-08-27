//
//  SliderScreenInteractor
//  AirportFinder
//
//  Created by Diego Castro on 26/08/24.
//

import Foundation

class AirportsMapInteractor: AirportsMapInteractorInProtocol {

    weak var presenter: AirportsMapInteractorOutProtocol?
    var apiHeaders =  [
        "x-rapidapi-key": "f944eb3c64msh7a171e89b578ce6p110eb0jsn6747a28335c3",
        "x-rapidapi-host": "aviation-reference-data.p.rapidapi.com"
    ]
    
    func consultAvailableAirPorts(location: CurrentLocation?) {
        var request = URLRequest(url: getURLWithCurrentlocation(location)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = apiHeaders
        
        let session = URLSession.shared
        let dataTask: Void = session.dataTask(with: request as URLRequest, completionHandler: { [weak self] (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                self?.decodeResponse(withData: data)
            }
        }).resume()
    }
    
    func getURLWithCurrentlocation(_ location: CurrentLocation?) -> URL? {
        let url = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(location?.latitude ?? 0.0)&lon=\(location?.longitude ?? 0.0)&radius=\(Int(location?.radius ?? 0))")
        
        return url
    }
    
    func decodeResponse(withData data: Data?) {
        do {
          let airPortsArray = try JSONDecoder().decode([AirportsMapEntity].self, from: data!)
            setMapPins(withAirPorts: airPortsArray)
        } catch {
            print("ParsingError", error.localizedDescription)
        }
    }
    
    func setMapPins(withAirPorts: [AirportsMapEntity] ) {
        
    }

}
