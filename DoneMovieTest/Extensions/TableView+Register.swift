//
//  TableView+Register.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

extension UITableView {
    
    enum Cell {
        var nameId: String {
            switch self {
            case .movieCell:
                return MovieCell.reuseIdentifier
            }
        }
        case movieCell
    }
    
    func register(cell: Cell) {
        let nib = UINib(nibName: cell.nameId, bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell.nameId)
    }
}
