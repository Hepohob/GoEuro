//
//  FlightViewController.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

class FlightViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var flightList:UICollectionView?
    @IBOutlet var indicator:UIActivityIndicatorView?
    @IBOutlet var buttonSort:UIButton?
    
    var list = Array<GoEuroStruct>()
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if listFlights.count > 0 {
            list = listFlights
            self.flightList?.reloadData()
            self.indicator?.stopAnimating()
        }
        
        flightList?.register(UINib(nibName: "CollectionCell", bundle:nil), forCellWithReuseIdentifier: reuseIdentifier)
        flightList?.frame = self.view.frame
        
        if Connection.isOn() {
            let manager = GoEuroData()
            manager.getTransport(by:.flight,
                                 successHandler: { (result) in
                                    self.list = result
                                    self.flightList?.reloadData()
                                    self.indicator?.stopAnimating()
            },
                                 
                                    failHandler: {(error) in
                                        print(error)
            
            })
        }
    }

    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        if let item = self.list[indexPath.item] as GoEuroStruct? {
            cell.indicator?.stopAnimating()
            cell.set(time:"\(item.departureTime) - \(item.arrivalTime)",
                    price: item.price,
                    changes: item.changes,
                    duration: item.duration)

            if let strURL = item.logo as String? {
                ImageManager.loadImage(strUrl: strURL) {(image, _ ) in
                    if let image = image {
                        cell.imageView?.image = image
                    }
                }
            }
        }
            
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Warning!", message: "Offer details are not yet implemented!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = flightList?.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = view.bounds.height / 6
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    @IBAction func pressSort(_ sender: UIButton) {
        list.sort(by: {$0.price < $1.price})
        flightList?.reloadData()
    }

}

