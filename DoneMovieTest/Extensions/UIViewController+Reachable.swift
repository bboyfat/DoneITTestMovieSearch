//
//  UIViewController+Reachable.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import UIKit

extension UIViewController {
    
    static let noInternetConnection = InternetConnectionController()
    
    func fireNointernetController(_ isReachable: Bool) {
        let controller = UIViewController.noInternetConnection
        controller.view.frame = UIScreen.main.bounds
        controller.modalPresentationStyle = .overFullScreen
        if isReachable {
            controller.stop()
            controller.dismiss(animated: true) {
                self.viewWillAppear(true)
            }
        } else {
            self.present(controller, animated: true, completion: nil)
            controller.start()
        }
    }
    
}

enum LoaderState {
    case show, hide
}
extension UIViewController {
    
    static let loader = LoaderController()
   
    
    func handleLoader(_ state: LoaderState) {
        let view = UIViewController.loader.view
        view?.frame = UIScreen.main.bounds
        switch state {
        case .show:
            self.view.addSubview(view ?? UIView())
            UIView.animate(withDuration: 0.5) {
                view?.alpha = 1
            }
        case .hide:
            UIView.animate(withDuration: 0.6) {
                view?.alpha = 0.1
            } completion: { (isCompleted) in
                view?.removeFromSuperview()
            }
            
        }
    }
    
}
