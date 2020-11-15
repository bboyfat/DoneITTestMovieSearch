//
//  APIClient.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Alamofire
import Foundation

protocol Fetcher {
    associatedtype M: Decodable
    func fetch(endPoint: EndPoint,handler: @escaping(M?, Error?) -> ())
}


struct ApiClient<M:Decodable>: Fetcher {
    
    func fetch(endPoint: EndPoint, handler: @escaping ((M?, Error?) -> ())) where M : Decodable {
        AF.request(endPoint.finalUrl, method: .get, parameters: nil).responseDecodable(of: M.self, queue: .global(qos: .utility)) { (response) in
            switch response.result {
            case .success(let answer):
                DispatchQueue.main.async {
                    handler(answer, nil)
                }
                EndPoint.page.incr()
            case .failure(let error):
                handler(nil, error)
            }
        }
    }
    
   
}
