//
//  ConfigsRepository.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation

protocol ConfigsRepository {
    @discardableResult
    func fetchConfigs(query: ConfigQuery, cached: @escaping (Config) -> Void,
                         completion: @escaping (Result<Config, Error>) -> Void) -> Cancellable?
    func fetchRecentsConfigs(completion: @escaping (Result<Config, Error>) -> Void)
}
