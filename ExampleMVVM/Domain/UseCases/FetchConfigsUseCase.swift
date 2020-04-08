//
//  FetchConfigsUseCase.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation

protocol FetchConfigsUseCase {
    func execute(requestValue: FetchConfigsUseCaseRequestValue,
                 cached: @escaping (Config) -> Void,
                 completion: @escaping (Result<Config, Error>) -> Void) -> Cancellable?
}

final class DefaultFetchConfigsUseCase: FetchConfigsUseCase {

    let configsRepository: ConfigsRepository
    //FIXME: maybe loginrepository here needed
    init(configsRepository: ConfigsRepository) {
        self.configsRepository = configsRepository
    }

    func execute(requestValue: FetchConfigsUseCaseRequestValue,
                 cached: @escaping (Config) -> Void,
                 completion: @escaping (Result<Config, Error>) -> Void) -> Cancellable? {

        return configsRepository.fetchConfigs(query: requestValue.query,
                                                cached: cached,
                                                completion: { result in

//            if case .success = result {
//                self.configsRepository.saveConfigs(query: requestValue.query) { _ in }
//            }

            completion(result)
        })
    }
}

struct FetchConfigsUseCaseRequestValue {
    let query: ConfigQuery
}
