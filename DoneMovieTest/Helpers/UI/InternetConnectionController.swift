//
//  InternetConnectionController.swift
//  Randevo
//
//  Created by Andrey Petrovskiy on 30.07.2020.
//  Copyright © 2020 Path Limited. All rights reserved.
//

import UIKit

class InternetConnectionController: UIViewController {

    @IBOutlet var internetConnectionView: InternetConnectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func start() {
        internetConnectionView.run()
        internetConnectionView.activityView.startAnimating()
    }
    
    func stop() {
        internetConnectionView.activityView.stopAnimating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
