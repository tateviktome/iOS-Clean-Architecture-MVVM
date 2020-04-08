//
//  LoginFlowCoordinator.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import Foundation
import UIKit

protocol LoginSceneCoordinationProtocol: class {
    func didFinishLogin()
}

protocol LoginFlowCoordinatorDependencies  {
    func makeLoginController(closures: LoginViewModelClosures) -> LoginViewController
}

class LoginFlowCoordinator {
    
    weak var delegate: LoginSceneCoordinationProtocol?
    
    private let navigationController: UINavigationController
    private let dependencies: LoginFlowCoordinatorDependencies

    init(navigationController: UINavigationController,
         dependencies: LoginFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with closures, this way this flow do not need to be strong referenced
        let closures = LoginViewModelClosures {
            self.delegate?.didFinishLogin()
        }
        let vc = dependencies.makeLoginController(closures: closures)

        navigationController.pushViewController(vc, animated: false)
    }
}

