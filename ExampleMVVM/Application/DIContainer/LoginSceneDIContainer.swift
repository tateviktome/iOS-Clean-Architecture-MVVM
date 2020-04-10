//
//  LoginSceneDIContainer.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation
import UIKit
import CoreData

final class LoginSceneDIContainer: LoginFlowCoordinatorDependencies {
    
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
    
    func makeLoginUseCase(completion: @escaping (LoginUseCase.ResultValue) -> Void) -> UseCase {
        return LoginUseCase(completion: completion, configsRepository: makeConfigsRepository())
    }
    
    // MARK: - Repositories
    func makeConfigsRepository() -> ConfigsRepository {
        return DefaultConfigsRepository(dataTransferService: dependencies.apiDataTransferService, cache: configQueriesStorage)
    }
    
    // MARK: - Splash
    func makeLoginController(closures: LoginViewModelClosures) -> LoginViewController {
        return LoginViewController.create(with: makeLoginViewModel(closures: closures))
    }
    
    func makeLoginViewModel(closures: LoginViewModelClosures) -> LoginViewModel {
        return LoginViewModel(useCase: makeLoginUseCase, closures: closures)
    }

    // MARK: - Flow Coordinators
    func makeLoginFlowCoordinator(navigationController: UINavigationController) -> LoginFlowCoordinator {
        return LoginFlowCoordinator(navigationController: navigationController,
                                           dependencies: self)
    }
}
