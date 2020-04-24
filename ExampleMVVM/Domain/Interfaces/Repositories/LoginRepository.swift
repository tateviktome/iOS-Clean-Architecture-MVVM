//
//  LoginRepository.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/13/20.
//

import Foundation

protocol LoginRepository {
    @discardableResult
    func login(body: LoginBody,
               completion: @escaping (Result<LoginResponse, Error>) -> Void) -> Cancellable?
}
