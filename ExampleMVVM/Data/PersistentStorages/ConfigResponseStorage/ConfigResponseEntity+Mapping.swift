//
//  ConfigResponseEntity+Mapping.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation
import CoreData

extension ConfigResponseEntity: DTOable, CoreDataManageable {
    func getResponseDTO() -> ResponseDTO? {
        return nil
    }
    
    func setResponseDTO(responseDTO: CoreDataResponseEntity) {}
    
    func toDTO() -> ResponseDTO {
        return ConfigResponseDTO(id: Int(idd),
                     avg_time: Int(avg_time),
                     currency: currency,
                     isHasData: isHasData)
    }
}

extension ConfigRequestEntity: CoreDataManageable {
    func getResponseDTO() -> ResponseDTO? {
        return self.response?.toDTO()
    }
    
    func setResponseDTO(responseDTO: CoreDataResponseEntity) {
        self.response = responseDTO as? ConfigResponseEntity
    }
}

extension ConfigRequestDTO: RequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> CoreDataRequestEntity {
        let entity: ConfigRequestEntity = .init(context: context)
        return entity
    }
}

extension ConfigResponseDTO: ResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> CoreDataResponseEntity {
        let entity: ConfigResponseEntity = .init(context: context)
        entity.idd = Int64(id!)
        entity.avg_time = Int64(avg_time!)
        entity.currency = currency
        entity.isHasData = isHasData ?? false
        return entity
    }
}
