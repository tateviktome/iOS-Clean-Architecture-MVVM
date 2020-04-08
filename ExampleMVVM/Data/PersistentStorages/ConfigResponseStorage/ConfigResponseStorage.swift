//
//  ConfigResponseStorage.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation

protocol ConfigResponseStorage {
    func getResponse(for request: ConfigRequestDTO, completion: @escaping (Result<ConfigResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: ConfigResponseDTO, for requestDto: ConfigRequestDTO)
}
