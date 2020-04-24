//
//  LoginUseCase.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import Foundation

protocol LoginCase: UseCase {
    @discardableResult
    func login(body: LoginBody, completion: ((Result<LoginResponse, Error>) -> Void)?) -> Cancellable?
    
    //
}

class LoginUseCase: LoginCase {
    typealias ResultValue = (Result<Config, Error>)

    private let completion: (ResultValue) -> Void
    private let configsRepository: ConfigsRepository
    private let loginRepository: LoginRepository

    init(completion: @escaping (ResultValue) -> Void,
         configsRepository: ConfigsRepository,
         loginRepository: LoginRepository) {

        self.completion = completion
        self.configsRepository = configsRepository
        self.loginRepository = loginRepository
    }
    
    func start() -> Cancellable? {
        configsRepository.fetchRecentsConfigs { (result) in
            self.completion(result)
        }
        return nil
    }
    
    func login(body: LoginBody, completion: ((Result<LoginResponse, Error>) -> Void)?) -> Cancellable? {
        loginRepository.login(body: body) { (result) in
            completion?(result)
        }
    }
}
