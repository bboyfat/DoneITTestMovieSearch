//
//  WatchTrailerController.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit
import WebKit


class WatchTrailerController: UIViewController {
    
    @IBOutlet var watchView: WatchTrailerView!
    @IBOutlet var webView: WKWebView!
    private var presenter: WatchTrailerPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        watchView.title.text = presenter?.getTitle() ?? ""
    }
    
    public func setPresenter(_ presenter: WatchTrailerPresenterProtocol?) {
        self.presenter = presenter
    }
    @IBAction func backBtnAction(_ sender: Any) {
        presenter?.back()
    }
    @IBAction func favoritesBtnAction(_ sender: Any) {
        presenter?.addToFavorites()
    }
    
    private func show(url: URL) {
        webView.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5) {[unowned self] in
            self.webView.alpha = 1
            self.webView.transform = .identity
            let rq = URLRequest(url: url)
            self.webView.load(rq)
        }
        
    }
    
}

extension WatchTrailerController: PresenterOutput {
    func update(_ viewState: ViewState) {
        switch viewState {
        case .finishWithSuccsses(let succsessType):
            switch succsessType {
            case .trailer(let url):
                show(url: url)
            case .favorites(let isFavorite):
                watchView.isFavorite(isFavorite)
            default:
                break
            }
        default:
            break
        }
    }
    
    
}
