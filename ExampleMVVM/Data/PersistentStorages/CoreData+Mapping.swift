//
//  CoreData+Mapping.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/9/20.
//

import Foundation
import CoreData

protocol RequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> CoreDataRequestEntity
}

protocol ResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> CoreDataResponseEntity
}

protocol CoreDataManageable {    
    func getResponseDTO () -> ResponseDTO?
    func setResponseDTO (responseDTO: CoreDataResponseEntity)
}
typealias CoreDataRequestEntity = NSManagedObject & CoreDataManageable
typealias CoreDataResponseEntity = NSManagedObject & CoreDataManageable

protocol DTOable {
    func toDTO() -> ResponseDTO
}
