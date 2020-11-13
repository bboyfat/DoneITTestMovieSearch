//
//  Router.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

protocol Router {
    func initial()
    func showMovie(m: MovieResponse)
    func pop()
    init(n: UINavigationController?, a: Assembly?)
}

class MainRouter: Router {
    
    private var n: UINavigationController?
    private var a: Assembly?
    
    func initial() {
        if let navigation = n {
            guard let controller = a?.initialController(self) else {
                return
            }
            navigation.pushViewController(controller, animated: true)
        }
    }
    
    func showMovie(m: MovieResponse) {
        if let navigation = n {
            guard let controller = a?.showController(self, m: m) else {
                return
            }
            navigation.pushViewController(controller, animated: true)
        }
    }
    
    func pop() {
        if let navigation = n {
            navigation.popViewController(animated: true)
        }
    }
    
    required init(n: UINavigationController?, a: Assembly?) {
        self.n = n
        self.n?.setNavigationBarHidden(true, animated: false)
        self.a = a
    }
    
    
}
