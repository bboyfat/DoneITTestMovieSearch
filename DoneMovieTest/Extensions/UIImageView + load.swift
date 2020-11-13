//
//  UIImageView + load.swift
//  GenTech
//
//  Created by Andrey Petrovskiy on 12.11.2020.
//

import Nuke
import UIKit

extension UIImageView {
    func loadImage(path: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w185//".appending(path)) else {
            return
        }
//        nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg
        Nuke.loadImage(with: url, into: self)
    }
}
