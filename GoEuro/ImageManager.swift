//
//  ImageManager.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

struct ImageManager {
    
    private static var cache = NSCache<AnyObject, AnyObject>()
    
    static func loadImage(strUrl: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        if (!strUrl.isEmpty) {
            DispatchQueue.global(qos: .background).async {
                if let image = self.cache.object(forKey: strUrl as AnyObject) as? UIImage {
                    DispatchQueue.main.async {
                        completionHandler(image, strUrl)
                    }
                    return
                }
                if let url = NSURL(string: strUrl),
                    let data = NSData(contentsOf: url as URL),
                    let image = UIImage(data: data as Data) {
                    self.cache.setObject(image, forKey: strUrl as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, strUrl)
                    }
                    return
                } else {
                    completionHandler(nil, strUrl)
                    return
                }
            }
        }
    }
    
}
