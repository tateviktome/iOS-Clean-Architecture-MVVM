//
//  SplashSceneDIContainer.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation
import UIKit
import CoreData

final class SplashSceneDIContainer: SplashFlowCoordinatorDependencies {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies

    // MARK: - Persistent Storage
    lazy var configQueriesStorage = CoreDataResponseStorage<ConfigRequestDTO, ConfigResponseDTO, ConfigResponseEntity, ConfigRequestEntity>(coreDataStorage: CoreDataStorage(), fetchRequestClosure: { _ in
        let request: NSFetchRequest = ConfigRequestEntity.fetchRequest()
        return request
    })

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Use Cases
    func makeFetchConfigsUseCase() -> FetchConfigsUseCase {
        return DefaultFetchConfigsUseCase(configsRepository: makeConfigsRepository())
    }
    
    // MARK: - Repositories
    func makeConfigsRepository() -> ConfigsRepository {
        return DefaultConfigsRepository(dataTransferService: dependencies.apiDataTransferService, cache: configQueriesStorage)
    }
    
    // MARK: - Splash
    func makeSplashViewController(closures: SplashViewModelClosures) -> SplashViewController {
        return SplashViewController.create(with: makeSplashViewModel(closures: closures))
    }
    
    func makeSplashViewModel(closures: SplashViewModelClosures) -> SplashViewModel {
        return SplashViewModel(useCase: makeFetchConfigsUseCase(), closures: closures)
    }

    // MARK: - Flow Coordinators
    func makeSplashFlowCoordinator(navigationController: UINavigationController) -> SplashFlowCoordinator {
        return SplashFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}

