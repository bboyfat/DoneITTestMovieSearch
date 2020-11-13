//
//  Assembly.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

protocol Assembly {
    func initialController(_ router: Router?) -> UIViewController
    func showController(_ router: Router?,m: MovieResponse) -> UIViewController
}

class MainAssembly: Assembly {
    func initialController(_ router: Router?) -> UIViewController {
        let controller = MovieListController()
        let view = controller.view as? MovieListView
        let presenter = MovieListPresenter(router, output: controller)
        let manager = MovieListManager(tableView: view?.tableView)
        controller.setManager(manager)
        controller.setPresenter(presenter)
        return controller
    }
    
    func showController(_ router: Router?, m: MovieResponse) -> UIViewController {
        let c = WatchTrailerController()
        let presenter = WatchTrailerPresenter(router, output: c, m: m)
        c.setPresenter(presenter)
        return c
    }
    
    
}
