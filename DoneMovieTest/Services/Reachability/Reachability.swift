//
//  Reachability.swift
//  DoneMovieTest
//
//  Created by Andrey Petrovskiy on 13.11.2020.
//

import Reachability
import UIKit


fileprivate var reachability: Reachability!

protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
}

extension ReachabilityObserverDelegate {
    
    func addReachabilityObserver() throws {
        reachability = try Reachability()
        
        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }
        
        try reachability.startNotifier()
    }
    
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}

class ReachabilityHandler: ReachabilityObserverDelegate {
    
    var controller: UIViewController? {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    
    required init() {
        try? addReachabilityObserver()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    func reachabilityChanged(_ isReachable: Bool) {
        if !isReachable {
            controller?.fireNointernetController(false)
        } else {
            controller?.fireNointernetController(true)
        }
    }
    
}

