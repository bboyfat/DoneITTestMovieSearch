//
//  MovieListManager.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

protocol MovieListManagerProtocol {
    func setup()
    func update(_ model: [MovieResponse])
    func showFavorites(_ favorites: [Favorite])
    func hideFavorites()
    func setDelegate(_ delegate: MovieListDelegate?)
    init(tableView: UITableView?)
}

protocol MovieListDelegate: class {
    func didChoose(movie: MovieResponse)
    func loadMore()
}


class MovieListManager: NSObject, MovieListManagerProtocol {
    
    private var tableView: UITableView?
    private var items: [MovieResponse] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private var favoriteItems: [MovieResponse] = []
    private var isFavorites: Bool = false
    weak var delegate: MovieListDelegate?
    
    func setup() {
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(cell: .movieCell)
    }
    
    func update(_ model: [MovieResponse]) {
        self.items.append(contentsOf: model)
    }
    
    func showFavorites(_ favorites: [Favorite]) {
        isFavorites = true
        favoriteItems = favorites.map({MovieResponse(m: $0)})
        tableView?.reloadData()
    }
    
    func hideFavorites() {
        isFavorites = false
        tableView?.reloadData()
    }
    
    func setDelegate(_ delegate: MovieListDelegate?) {
        self.delegate = delegate
    }
    
    required init(tableView: UITableView?) {
        self.tableView = tableView
    }
    
}

extension MovieListManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = isFavorites ? favoriteItems[indexPath.row] : items[indexPath.row]
        delegate?.didChoose(movie: item)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !isFavorites else {
            return
        }
        if indexPath.row == items.count - 1 {
            delegate?.loadMore()
        }
    }
}

extension MovieListManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFavorites ? favoriteItems.count : items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell else { return UITableViewCell() }
        let item = isFavorites ? favoriteItems[indexPath.row] : items[indexPath.row]
        cell.set(item)
        return cell
    }
    
}
