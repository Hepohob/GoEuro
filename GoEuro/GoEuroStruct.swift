//
//  GoEuroStruct.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

enum TransportType {
    case flight
    case bus
    case train
}

class GoEuroStruct:NSObject, NSCoding {

    var logo:String
    var departureTime:String
    var arrivalTime:String
    var changes:String
    var price:String
    var duration:String
    
    //MARK: NSCoding
    
    init(logo:String, departureTime:String, arrivalTime:String, changes:String, price:String, duration:String)
    {
        self.logo = logo
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.changes = changes
        self.price = price
        self.duration = duration
    }

    required init(coder aDecoder: NSCoder) {
        self.logo = aDecoder.decodeObject(forKey: "logo") as! String
        self.departureTime = aDecoder.decodeObject(forKey: "departureTime") as! String
        self.arrivalTime = aDecoder.decodeObject(forKey: "arrivalTime") as! String
        self.duration = aDecoder.decodeObject(forKey: "duration") as! String
        self.changes = aDecoder.decodeObject(forKey: "changes") as! String
        self.price = aDecoder.decodeObject(forKey: "price") as! String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(logo, forKey: "logo")
        aCoder.encode(departureTime, forKey: "departureTime")
        aCoder.encode(arrivalTime, forKey: "arrivalTime")
        aCoder.encode(duration, forKey: "duration")
        aCoder.encode(changes, forKey: "changes")
        aCoder.encode(price, forKey: "price")        
    }
    
}
