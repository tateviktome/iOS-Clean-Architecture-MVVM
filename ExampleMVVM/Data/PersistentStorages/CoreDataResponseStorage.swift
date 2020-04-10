//
//  CoreDataResponseStorage.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/9/20.
//

import Foundation
import CoreData

protocol ResponseStorage {
    associatedtype T
    associatedtype U
    
    func getResponse(for request: T, completion: @escaping (Result<U?, CoreDataStorageError>) -> Void)
    func save(response: U, for requestDto: T)
}

final class CoreDataResponseStorage<Request: RequestDTO, Response: ResponseDTO, Entity: CoreDataResponseEntity, RequestEntity: CoreDataRequestEntity> {

    private let coreDataStorage: CoreDataStorage
    private let fetchRequestClosure: ((_ requestDTO: Request) -> NSFetchRequest<RequestEntity>)

    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared, fetchRequestClosure: @escaping ((_ requestDTO: Request) -> NSFetchRequest<RequestEntity>)) {
        self.coreDataStorage = coreDataStorage
        self.fetchRequestClosure = fetchRequestClosure
    }

    private func deleteResponse(for requestDto: Request, in context: NSManagedObjectContext) {
        let request = self.fetchRequestClosure(requestDto)

        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
}

extension CoreDataResponseStorage: ResponseStorage {

    func getResponse(for requestDto: Request, completion: @escaping (Result<Response?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let request = self.fetchRequestClosure(requestDto)

                let result = try context.fetch(request).first

                if let item = result?.getResponseDTO() {
                    completion(.success(item as? Response))
                }
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
                print(error)
            }
        }
    }

    func save(response responseDto: Response, for requestDto: Request) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(for: requestDto, in: context)

                let requestEntity = requestDto.toEntity(in: context)
                requestEntity.setResponseDTO(responseDTO: responseDto.toEntity(in: context))

                try context.save()
            } catch {
                print(error)
            }
        }
    }
}

class A {
    var storage = CoreDataResponseStorage<ConfigRequestDTO, ConfigResponseDTO, ConfigResponseEntity, ConfigRequestEntity>(coreDataStorage: CoreDataStorage(), fetchRequestClosure: { _ in
        let request: NSFetchRequest = ConfigRequestEntity.fetchRequest()
        return request
    })
}
