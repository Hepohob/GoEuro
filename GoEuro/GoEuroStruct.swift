//
//  GoEuroStruct.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

struct GoEuroStruct {
    var logo:String
    var departureTime:String
    var arrivalTime:String
    var changes:String
    var price:String
    var duration:String
    var type:TransportType
    
    enum TransportType {
        case flight
        case bus
        case train
    }
}
