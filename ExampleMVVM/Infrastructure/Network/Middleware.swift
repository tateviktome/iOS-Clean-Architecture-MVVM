//
//  Middleware.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/13/20.
//

import Foundation

public struct MiddlewareResponse {
    public var body: Data?
    public var request: URLRequest?
    public var response: HTTPURLResponse?
}

public enum MiddlewareResult {
    case `continue`
    case abort
}
