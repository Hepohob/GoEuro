//
//  RootViewController.swift
//  GoEuro
//
//  Created by Алексей Неронов on 10.12.16.
//  Copyright © 2016 Алексей Неронов. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    
    @IBOutlet var topBar: UITabBar!
    
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var navHeight = CGFloat(100)
    var fontSize = CGFloat(18)
    var labelFontSize = CGFloat(14)

    override func viewDidLoad() {
        super.viewDidLoad()
        topBar.frame = CGRect(x: 0,
                              y: 0,
                              width: self.view.bounds.size.width,
                              height: navHeight)
        topBar.autoresizingMask = [.flexibleTopMargin,
                                   .flexibleLeftMargin,
                                   .flexibleWidth,
                                   .flexibleHeight]
        let image = UIImage().createSelectionIndicator(color: UIColor.orange,
                                                       size: CGSize(width: 50, height: navHeight),
                                                       lineWidth: CGFloat(4))
        topBar.selectionIndicatorImage = image
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -navHeight/5)
        if let attributes = [NSFontAttributeName:UIFont(name: "Arial", size: fontSize)!,
                             NSForegroundColorAttributeName: UIColor.white] as  [String: Any]? {
            UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        }
        titleLabel = putLabel(at: CGRect(x: 0, y: 20, width: self.view.bounds.size.width, height: 15),
                              text: "Origin - Destination")
        self.view.addSubview(titleLabel)
        dateLabel = putLabel(at: CGRect(x: 0, y: 36, width: self.view.bounds.size.width, height: 15),
                              text: "jun 07")
        self.view.addSubview(dateLabel)
    }

    override func viewDidLayoutSubviews() {
        if self.topBar != nil {
            self.topBar.frame = CGRect(x: 0,
                                       y: 0,
                                       width: self.view.bounds.size.width,
                                       height: navHeight)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: Helper
    
    func putLabel(at frame:CGRect, text:String) -> UILabel {
        let label = UILabel(frame: frame)
        label.font = UIFont(name: "Arial", size: labelFontSize)
        label.textAlignment = .center
        label.text = text
        label.textColor = UIColor.white
        return label
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


