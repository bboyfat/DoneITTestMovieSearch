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
