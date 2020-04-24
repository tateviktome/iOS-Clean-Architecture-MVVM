//
//  Middlewares.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/13/20.
//

import Foundation
import UIKit

struct Middlewares {
     static let maintenance: (MiddlewareResponse) -> (MiddlewareResult) = { (response) in
        if response.response?.statusCode == 502 {
            let application = UIApplication.shared
            if let appDelegate = application.delegate as? AppDelegate, let coordinator = appDelegate.appFlowCoordinator {
                //coordinator show maintenance screen
            }
            return .abort
        }
        
        return .continue
    }
    
    static let error: (MiddlewareResponse) -> (MiddlewareResult) = { (response) in
        if response.response?.statusCode == 404 {
            let application = UIApplication.shared
            if let appDelegate = application.delegate as? AppDelegate, let coordinator = appDelegate.appFlowCoordinator {
                print("404 happened")
                //coordinator show error screen
                //loading removal
            }
        }
        
        return .continue //continues request anyway for error block to be reachable
    }
}
