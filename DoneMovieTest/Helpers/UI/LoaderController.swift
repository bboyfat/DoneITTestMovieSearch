//
//  LoaderController.swift
//  Randevo
//
//  Created by Andrey Petrovskiy on 10.06.2020.
//  Copyright © 2020 K&A CORPORATION LTD. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoaderController: UIViewController {

    @IBOutlet var activityIndicatorView: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityIndicatorView.transform = CGAffineTransform(rotationAngle: -.pi/2)
        activityIndicatorView.type = .ballRotateChase
        activityIndicatorView.startAnimating()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        activityIndicatorView.stopAnimating()
    }
    
    private func hideLoaderManualy() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleHide))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleHide() {
        self.dismiss(animated: true, completion: nil)
    }
}

