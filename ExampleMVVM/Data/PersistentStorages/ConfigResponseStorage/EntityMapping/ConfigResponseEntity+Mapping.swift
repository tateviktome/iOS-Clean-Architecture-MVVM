//
//  ConfigResponseEntity+Mapping.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation
import CoreData

extension ConfigResponseEntity {
    func toDTO() -> ConfigResponseDTO {
        return .init(id: Int(idd),
                     avg_time: Int(avg_time),
                     currency: currency,
                     isHasData: isHasData)
    }
}

extension ConfigRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> ConfigRequestEntity {
        let entity: ConfigRequestEntity = .init(context: context)
        return entity
    }
}

extension ConfigResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> ConfigResponseEntity {
        let entity: ConfigResponseEntity = .init(context: context)
        entity.idd = Int64(id!)
        entity.avg_time = Int64(avg_time!)
        entity.currency = currency
        entity.isHasData = isHasData ?? false
        return entity
    }
}
