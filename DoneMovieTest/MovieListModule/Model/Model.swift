//
//  Model.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Foundation

struct APIResponse: Decodable {
    var page: Int
    var results: [MovieResponse]
}

struct MovieResponse: Codable {
    var poster_path: String?
    var overview: String?
    var id: Int?
    var original_title: String?
    var title: String?
    
    init (m: Favorite) {
        self.poster_path = m.poster_path
        self.overview = m.overview
        self.id = Int(m.id)
        self.original_title = m.original_title
        self.title = m.title
    }
}



