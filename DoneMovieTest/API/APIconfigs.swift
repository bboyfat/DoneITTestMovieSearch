//
//  APIconfigs.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Foundation

enum EndPoint {
    
    
    typealias RawValue = URL
    
    static var page: Int = 1
    static var apiKey = "fd0feaf9dcefc1ec65bca5ce52e90392"
    static let baseUrl: String = "https://api.themoviedb.org/3/"
    
    var finalUrl: URL {
        switch self {
        case .movieList:
            var urlComponents = URLComponents(string: EndPoint.baseUrl.appending("movie/popular"))!
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: EndPoint.apiKey),
                URLQueryItem(name: "page", value: "\(EndPoint.page)")
            ]
            return urlComponents.url!
            
        case .video(let videoId):
            let urlString = EndPoint.baseUrl.appending("movie/\(videoId)/videos")
            var urlComponents = URLComponents(string: urlString)!
            urlComponents.queryItems = [
                URLQueryItem(name: "api_key", value: EndPoint.apiKey)
            ]
            return urlComponents.url!
        case .youtube(let key):
            return URL(string: "https://www.youtube.com/embed/\(key)")!
        }
        
    }
    
    case movieList
    case video(String)
    case youtube(String)
    
}
