//
//  DefaultLoginRepository.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/13/20.
//

import Foundation

final class DefaultLoginRepository {

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }
}

extension DefaultLoginRepository: LoginRepository {
    func login(body: LoginBody, completion: @escaping (Result<LoginResponse, Error>) -> Void) -> Cancellable? {
        let task = RepositoryTask()

        let endpoint = APIEndpoints.doLogin(with: body)
        task.networkTask = self.dataTransferService.request(with: endpoint) { response in
            switch response {
            case .success(let response):
                completion(.success(LoginResponse()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
