//
//  CoreDataConfigResponseStorage.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation
import CoreData

final class CoreDataConfigResponseStorage {

    private let coreDataStorage: CoreDataStorage

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }

    // MARK: - Private

    private func fetchRequest(for requestDto: ConfigRequestDTO) -> NSFetchRequest<ConfigRequestEntity> {
        let request: NSFetchRequest = ConfigRequestEntity.fetchRequest()
        return request
    }

    private func deleteResponse(for requestDto: ConfigRequestDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest(for: requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataConfigResponseStorage: ConfigResponseStorage {

    func getResponse(for requestDto: ConfigRequestDTO, completion: @escaping (Result<ConfigResponseDTO?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request = self.fetchRequest(for: requestDto)

                let result = try context.fetch(request).first

                completion(.success(result?.response?.toDTO()))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
                print(error)
            }
        }
    }

    func save(response responseDto: ConfigResponseDTO, for requestDto: ConfigRequestDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.response = responseDto.toEntity(in: context)

                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

