//
//  Presenter.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Foundation

enum ViewState {
    case loading
    case finishWithSuccsses(SuccessType)
    case failure(String?)
}

enum SuccessType {
    case movies([MovieResponse])
    case trailer(URL)
    case favorites(Bool)
    case showFavorites([Favorite])
    case hideFavorites
}

protocol Presenter {
    init(_ router: Router?, output: PresenterOutput?)
}

protocol ListPresenterProtocol: Presenter {
    func loadMovies()
    func switchFavorites(segment: Int)
    func showTrailer(_ m: MovieResponse)
}
protocol PresenterOutput: class {
    func update(_ viewState: ViewState)
}

class MovieListPresenter: ListPresenterProtocol {
    
    private var router: Router?
    private var dataBase = CorDataWorker.instance
    weak var output: PresenterOutput?
    
    func loadMovies() {
        ApiClient<APIResponse>().fetch(endPoint: .movieList) {[unowned self] (answer, error) in
            guard error == nil else {self.handleError(error?.localizedDescription); return}
            self.output?.update(.finishWithSuccsses(.movies(answer?.results ?? [])))
        }
    }
    
    func switchFavorites(segment: Int) {
        segment == 1 ? output?.update(.finishWithSuccsses(.showFavorites(dataBase.fetch()))) : output?.update(.finishWithSuccsses(.hideFavorites))
    }
    
    func showTrailer(_ m: MovieResponse) {
        router?.showMovie(m: m)
    }
    
    func subscribeOnFavorites() {
        dataBase.favoriteDidRemoved = {[weak self] in
            guard let self = self else {return}
            self.output?.update(.finishWithSuccsses(.showFavorites(self.dataBase.fetch())))
        }
    }
    
    private func handleError(_ message: String?) {
        output?.update(.failure(message))
    }
    
    required init(_ router: Router?, output: PresenterOutput?) {
        self.router = router
        self.output = output
        subscribeOnFavorites()
    }
}
