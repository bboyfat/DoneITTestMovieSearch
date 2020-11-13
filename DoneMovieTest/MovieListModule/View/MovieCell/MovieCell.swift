//
//  MovieCell.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var overview: UILabel!
    @IBOutlet var original_title: UILabel!
    @IBOutlet var title: UILabel!
    @IBOutlet var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension MovieCell {
    func set(_ item: MovieResponse) {
        title.text = item.title
        original_title.text = item.original_title
        overview.text = item.overview
        poster.loadImage(path: item.poster_path ?? "")
    }
}
