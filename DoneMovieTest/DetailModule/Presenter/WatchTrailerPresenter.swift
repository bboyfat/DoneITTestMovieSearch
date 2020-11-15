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
        guard let id = m?.id else {handleError("Can't get video's id"); return}
        output?.update(.loading)
        isFavorite()
        ApiClient<VideoResponse>().fetch(endPoint: .video("\(id)")) {[unowned self] (video, error) in
            guard error == nil,
                  let key = video?.results.first?.key
            else {self.handleError(error?.localizedDescription); return}
            
            let url = EndPoint.youtube(key).finalUrl
            self.output?.update(.finishWithSuccsses(.trailer(url)))
        }
        
    }
    
    private func handleError(_ message: String?) {
        output?.update(.failure(message))
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



