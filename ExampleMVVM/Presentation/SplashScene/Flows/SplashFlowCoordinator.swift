//
//  SplashFlowCoordinator.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import Foundation
import UIKit

protocol SplashSceneCoordinationProtocol: class {
    func didFinishSplash()
}

protocol SplashFlowCoordinatorDependencies  {
    func makeSplashViewController(closures: SplashViewModelClosures) -> SplashViewController
}

class SplashFlowCoordinator {
    
    weak var delegate: SplashSceneCoordinationProtocol?
    
    private let navigationController: UINavigationController
    private let dependencies: SplashFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: SplashFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with closures, this way this flow do not need to be strong referenced
        let closures = SplashViewModelClosures {
            self.delegate?.didFinishSplash()
        }
        let vc = dependencies.makeSplashViewController(closures: closures)

        navigationController.pushViewController(vc, animated: false)
    }
}

