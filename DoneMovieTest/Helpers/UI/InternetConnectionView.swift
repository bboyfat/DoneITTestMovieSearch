//
//  InternetConnectionView.swift
//  Randevo
//
//  Created by Andrey Petrovskiy on 30.07.2020.
//  Copyright © 2020 Path Limited. All rights reserved.
//

import UIKit

class InternetConnectionView: UIView {
    
    @IBOutlet var topConstraint: NSLayoutConstraint!
    @IBOutlet var notifContainer: UIView!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notifContainer.addBorder(width: 0.4, color: .white)
    }
    
    func run() {
        self.layoutIfNeeded()
        self.topConstraint.constant = 55
        UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        })
    }
    
}
