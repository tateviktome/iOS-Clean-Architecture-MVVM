//
//  DefaultConfigsRepository.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation

final class DefaultConfigsRepository {

    private let dataTransferService: DataTransferService
    private let cache: CoreDataResponseStorage<ConfigRequestDTO, ConfigResponseDTO, ConfigResponseEntity, ConfigRequestEntity>

    init(dataTransferService: DataTransferService, cache: CoreDataResponseStorage<ConfigRequestDTO, ConfigResponseDTO, ConfigResponseEntity, ConfigRequestEntity>) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultConfigsRepository: ConfigsRepository {
    func fetchConfigs(query: ConfigQuery, cached: @escaping (Config) -> Void,
                      completion: @escaping (Result<Config, Error>) -> Void) -> Cancellable? {
        let requestDTO = ConfigRequestDTO()
        let task = RepositoryTask()

        cache.getResponse(for: requestDTO) { result in

            if case let .success(moviesResponseDTO?) = result {
                cached(moviesResponseDTO.mapToDomain())
            }
            guard !task.isCancelled else { return }

            let endpoint = APIEndpoints.getConfigs(with: requestDTO)
            task.networkTask = self.dataTransferService.request(with: endpoint) { response in
                switch response {
                case .success(let responseDTO):
                    self.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.mapToDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        return task
    }
    
    func fetchRecentsConfigs(completion: @escaping (Result<Config, Error>) -> Void) {
        cache.getResponse(for: ConfigRequestDTO()) { result in

            if case let .success(responseDTO?) = result {
                completion(.success(responseDTO.mapToDomain()))
            } else if case let .failure(error) = result {
                completion(.failure(error))
            }
        }
    }
}
