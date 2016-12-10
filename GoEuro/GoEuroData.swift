//
//  GoEuroData.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import Foundation

class GoEuroData {
    
    func getTransport(by type:GoEuroStruct.TransportType,
                      successHandler: @escaping (_ transportArray: Array<GoEuroStruct>) -> (),
                         failHandler: @escaping (_ error: Error) -> ())
    {
        var url = ""
        
        switch type {
        case .flight:
            url = "https://api.myjson.com/bins/w60i"
        case .bus:
            url = "https://api.myjson.com/bins/37yzm"
        case .train:
            url = "https://api.myjson.com/bins/3zmcy"
        }
        
        guard let pathUrl = URL(string: "\(url)") else {
            return
        }
        var request = URLRequest(url: pathUrl )
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue:OperationQueue.main)
        
        let task = session.dataTask(with: request as URLRequest) {
            data, response, error in
            
            // Check for error
            if error != nil {
                print("RESTAPIManager GETRequest error=\(error!)")
                failHandler(error!)
                return
            }
            // Convert server json response to Dictionary or Array inside Dictionary
            do {
                if let convertedJsonIntoArray =
                    try JSONSerialization.jsonObject(with: data!, options: []) as? Array<Dictionary<String, Any>> {
                    var resultArray = Array<GoEuroStruct>()
                    for element in convertedJsonIntoArray {
                        var changes = "Direct"
                        var url = ""
                        var price = "error"
                        if let changesInt = element["number_of_stops"] as! Int? {
                            if changesInt > 0 {
                                changes = "\(changesInt) stops"
                            }
                        }
                        if let logoURL = element["provider_logo"] as! String? {
                            url = (logoURL as NSString).replacingOccurrences(of: "{size}", with: "63")
                        }
                        if var prc = element["price_in_euros"] {
                            if let tmp = prc as? Double {
                                prc = Double(round(100.0 * tmp)/100)
                            }
                            price = "€\(prc)"
                        }
                          if var add = GoEuroStruct(logo: url,
                                                  departureTime: element["departure_time"] as! String? ?? "",
                                                  arrivalTime: element["arrival_time"] as! String? ?? "",
                                                  changes: changes,
                                                  price: price,
                                                  duration: "",
                                                  type: type) as GoEuroStruct?{
                            add.duration = TimeDiff.departure(add.departureTime, andArrival: add.arrivalTime)
                            resultArray += [add]
                        }
                    }
                    successHandler(resultArray)
                    return
                }
            } catch let error as NSError {
                print("RESTAPIManager GETRequest convertedJsonIntoDict \(error.localizedDescription)")
                failHandler(error)
            }
            
        }
        
        task.resume()
    }

}
