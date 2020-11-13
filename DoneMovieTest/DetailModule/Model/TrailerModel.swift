//
//  TrailerModel.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Foundation

struct VideoResponse: Decodable {
    var id: Int
    var results: [Video]
    struct Video: Decodable {
        var key: String
    }
}
