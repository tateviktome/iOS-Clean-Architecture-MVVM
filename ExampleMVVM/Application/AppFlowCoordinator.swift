//
//  AppFlowCoordinator.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 03.03.19.
//

import UIKit

class AppFlowCoordinator {

    var navigationController: UINavigationController
    private let appDIContainer: AppDIContainer
    
    init(navigationController: UINavigationController,
         appDIContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
    }
    
    func start() {
        self.showSplash()
    }
    
    func showMovies() {
        let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()
    }
    
    func showLogin() {
        let loginDIContainer = appDIContainer.makeLoginDIContainer()
        let flow = loginDIContainer.makeLoginFlowCoordinator(navigationController: navigationController)
        flow.delegate = self
        flow.start()
    }
    
    func showSplash() {
        let sceneDIContainer = appDIContainer.makeSplashDIContainer()
        let flow = sceneDIContainer.makeSplashFlowCoordinator(navigationController: navigationController)
        flow.delegate = self
        flow.start()
    }
}

extension AppFlowCoordinator: SplashSceneCoordinationProtocol, LoginSceneCoordinationProtocol {
    func didFinishSplash() {
        self.showLogin()
    }
    
    func didFinishLogin() {
        self.showMovies()
    }
}
