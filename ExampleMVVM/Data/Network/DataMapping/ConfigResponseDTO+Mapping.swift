//
//  ConfigResponseDTO+Mapping.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation

struct ConfigResponseDTO: Codable {
    var id: Int?
    var avg_time: Int?
    var currency: String?
    var isHasData: Bool?
}

extension ConfigResponseDTO {
    func mapToDomain() -> Config {
        return .init(id: id!, avg_time: avg_time!, currency: currency!, isHasData: isHasData!)
    }
}
