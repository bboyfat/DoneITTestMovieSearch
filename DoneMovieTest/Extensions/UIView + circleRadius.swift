//
//  UIView + circleRadius.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import UIKit

extension UIView {
    func circleRadius() {
        self.layer.cornerRadius = self.frame.height/2
    }
}
