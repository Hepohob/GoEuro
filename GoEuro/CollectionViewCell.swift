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
        imageView?.image = UIImage(named: "nologo")
        timeLabel?.text = nil
        priceLabel?.text = nil
        changesLabel?.text = nil
        durationLabel?.text = nil
        indicator?.startAnimating()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = UIImage(named: "nologo")
        timeLabel?.text = nil
        priceLabel?.text = nil
        changesLabel?.text = nil
        durationLabel?.text = nil
        indicator?.startAnimating()
    }
    
    func set(time:String, price:String, changes:String, duration:String) {
        let attribute = [ NSFontAttributeName: UIFont(name: "Arial-BoldMT", size: 17.0)! ]
        let string = NSMutableAttributedString(string: "\(price)")
        let range = NSRange(location: price.characters.count - 2, length: 2)
        string.addAttributes(attribute, range: range)
        self.priceLabel?.attributedText = string
        self.changesLabel?.text = changes
        self.durationLabel?.text = duration
        self.timeLabel?.text = time
    }
}
