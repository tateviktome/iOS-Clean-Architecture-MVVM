//
//  LoginUseCase.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import Foundation

class LoginUseCase: UseCase {
    typealias ResultValue = (Result<Config, Error>)

    private let completion: (ResultValue) -> Void
    private let configsRepository: ConfigsRepository

    init(completion: @escaping (ResultValue) -> Void,
         configsRepository: ConfigsRepository) {

        self.completion = completion
        self.configsRepository = configsRepository
    }
    
    func start() -> Cancellable? {
        configsRepository.fetchRecentsConfigs { (result) in
            self.completion(result)
        }
        return nil
    }
}
