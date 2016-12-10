//
//  CollectionViewCell.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView:UIImageView?
    @IBOutlet var timeLabel:UILabel?
    @IBOutlet var priceLabel:UILabel?
    @IBOutlet var changesLabel:UILabel?
    @IBOutlet var durationLabel:UILabel?
    @IBOutlet var indicator:UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        timeLabel?.text = nil
        priceLabel?.text = nil
        changesLabel?.text = nil
        durationLabel?.text = nil
        indicator?.startAnimating()
    }
    
}
