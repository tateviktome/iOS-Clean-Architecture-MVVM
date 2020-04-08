//
//  LoginViewModel.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import Foundation

typealias LoginUseCaseFactory = (@escaping (LoginUseCase.ResultValue) -> Void
    ) -> UseCase

struct LoginViewModelClosures {
    let closeLogin: () -> Void
}

protocol LoginViewModelInput {
    func getConfigs()
    func loginButtinPress()
}

protocol LoginViewModelOutput {
    var title: Observable<String> { get }
}

class LoginViewModel: LoginViewModelInput, LoginViewModelOutput {
    var title: Observable<String> = Observable("")
    var factory: LoginUseCaseFactory
    var closures: LoginViewModelClosures
    
    init(useCase: @escaping LoginUseCaseFactory, closures: LoginViewModelClosures) {
        self.closures = closures
        self.factory = useCase
    }
    
    func getConfigs() {
        let completion: (LoginUseCase.ResultValue) -> Void = { result in
            switch result {
            case .success(let item):
                self.title.value = item.currency
            case .failure: break
            }
        }
        let useCase = factory(completion)
        useCase.start()
    }
    
    func loginButtinPress() {
        closures.closeLogin()
    }
}
