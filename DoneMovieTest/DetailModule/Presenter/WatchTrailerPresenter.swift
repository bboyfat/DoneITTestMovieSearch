//
//  WatchTrailerPresenter.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Foundation

protocol WatchTrailerPresenterProtocol: Presenter {
    func back()
    func addToFavorites()
    func getURL()
    func getTitle() -> String?
}

class WatchTrailerPresenter: WatchTrailerPresenterProtocol {
    
    private var router: Router?
    weak var output: PresenterOutput?
    private var coreDataWorker = CorDataWorker.instance
    private var m: MovieResponse?
    
    
    func back() {
        router?.pop()
    }
    
    func getTitle() -> String? {
        return m?.title
    }
    
    func getURL() {
        guard let id = m?.id else {return}
        isFavorite()
        ApiClient<VideoResponse>().fetch(endPoint: .video("\(id)")) {[unowned self] (video) in
            guard let key = video.results.first?.key else {return}
            guard let url = URL(string: "https://www.youtube.com/embed/\(key)") else {return}
            self.output?.update(.finishWithSuccsses(.trailer(url)))
        }
        
    }
    
    func isFavorite() {
        guard let m = m else {return}
        output?.update(.finishWithSuccsses(.favorites(coreDataWorker.isContain(m: m))))
    }
    
    func addToFavorites() {
        coreDataWorker.updateFavorites(handler: { (isFavorite) in
            self.output?.update(.finishWithSuccsses(.favorites(isFavorite)))
        }, m: m)
    }
    
    required init(_ router: Router?, output: PresenterOutput?) {
        self.router = router
        self.output = output
    }
    
    convenience init(_ router: Router?, output: PresenterOutput?, m: MovieResponse) {
        self.init(router, output: output)
        self.m = m
    }
}



