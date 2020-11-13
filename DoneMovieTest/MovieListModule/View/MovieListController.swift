//
//  MovieListController.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

class MovieListController: UIViewController {

    @IBOutlet var movieListView: MovieListView!
    private var dataSourceManager: MovieListManagerProtocol?
    private var presenter: ListPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSourceManager?.setup()
        dataSourceManager?.setDelegate(self)
        presenter?.loadMovies()
    }
    
    @IBAction func segmenAction(_ sender: UISegmentedControl) {
        presenter?.switchFavorites(segment: sender.selectedSegmentIndex) 
    }
    
    public func setManager(_ manager: MovieListManagerProtocol?) {
        self.dataSourceManager = manager
    }
    
    public func setPresenter(_ presenter: ListPresenterProtocol?) {
        self.presenter = presenter
    }
}

extension MovieListController: MovieListDelegate {
    func loadMore() {
        presenter?.loadMovies()
    }
    
    func didChoose(movie: MovieResponse) {
        presenter?.showTrailer(movie)
    }
}

extension MovieListController: PresenterOutput {
    func update(_ viewState: ViewState) {
        switch viewState {
        case .finishWithSuccsses(let successType):
            switch successType {
            case .movies(let movies):
                dataSourceManager?.update(movies)
            case .showFavorites(let favorites):
                dataSourceManager?.showFavorites(favorites)
            case .hideFavorites:
                dataSourceManager?.hideFavorites()
            default:
                break
            }
        default:
            break
        }
    }
}
