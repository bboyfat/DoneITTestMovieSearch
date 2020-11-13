//
//  WatchVideoView.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

class WatchTrailerView: UIView {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var backBtnOutlet: UIButton!
    @IBOutlet var favoriteBtnOutlet: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backBtnOutlet.circleRadius()
    }
    
    
    func isFavorite(_ isFavorite: Bool) {
        let title = isFavorite ? "Remove from favorites" : "Add to favorites"
        let backgroundColor: UIColor = isFavorite ? .red : .green
        favoriteBtnOutlet.setTitle(title, for: .normal)
        favoriteBtnOutlet.backgroundColor = backgroundColor
    }
}
