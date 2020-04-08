//
//  Config.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/7/20.
//

import Foundation

struct Config: Equatable {
    let id: Int
    let avg_time: Int
    let currency: String
    let isHasData: Bool
}

struct ConfigQuery: Equatable {}
