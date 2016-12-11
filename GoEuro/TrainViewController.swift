//
//  TrainViewController.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

class TrainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var trainList:UICollectionView?
    @IBOutlet var indicator:UIActivityIndicatorView?
    @IBOutlet var buttonSort:UIButton?

    var list = Array<GoEuroStruct>()
    let reuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if listTrains.count > 0 {
            list = listTrains
            self.trainList?.reloadData()
            self.indicator?.stopAnimating()
        }

        trainList?.register(UINib(nibName: "CollectionCell", bundle:nil), forCellWithReuseIdentifier: reuseIdentifier)
        trainList?.frame = self.view.frame
        
        if Connection.isOn() {
            let manager = GoEuroData()
            manager.getTransport(by:.train,
                                 successHandler: { (result) in
                                    self.list = result
                                    self.trainList?.reloadData()
                                    self.indicator?.stopAnimating()
            },
                                 
                                 failHandler: {(error) in
                                    print(error)
                                    
            })
        }
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CollectionViewCell
        if let item = self.list[indexPath.item] as GoEuroStruct? {
            if let strURL = item.logo as String? {
                ImageManager.loadImage(strUrl: strURL) {(image, _ ) in
                    if let image = image {
                        cell.indicator?.stopAnimating()
                        cell.set(with: image,
                                 time:"\(item.departureTime) - \(item.arrivalTime)",
                            price: item.price,
                            changes: item.changes,
                            duration: item.duration)
                    }
                }
            }
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        let alert = UIAlertController(title: "Warning!", message: "Offer details are not yet implemented!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok.", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let layout = trainList?.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = view.bounds.height / 6
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    @IBAction func pressSort(_ sender: UIButton) {
        list.sort(by: {$0.price < $1.price})
        trainList?.reloadData()
    }

}
