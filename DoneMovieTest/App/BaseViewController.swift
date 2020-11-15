//
//  BaseViewController.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 15.11.2020.
//

import UIKit

class StateViewController: UIViewController {
    
    var viewState: ViewState = .loading {
        didSet {
            DispatchQueue.main.async {[unowned self] in
                switch self.viewState {
                case .loading:
                    self.handleLoader(.show)
                case .failure(let message):
                    self.showError(message)
                    self.handleLoader(.hide)
                default:
                    self.handleLoader(.hide)
                }
            }
            
        }
    }
    
    func showError(_ message: String?) {
        let ac = UIAlertController(title: "ERROR", message: message, preferredStyle: .actionSheet)
        let ok = UIAlertAction(title: "OK", style: .default)
        ac.addAction(ok)
        self.present(ac, animated: true)
    }
}
