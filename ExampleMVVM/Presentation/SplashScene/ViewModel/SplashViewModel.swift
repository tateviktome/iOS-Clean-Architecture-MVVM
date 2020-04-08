//
//  SplashViewModel.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import Foundation

struct SplashViewModelClosures {
    let closeSplash: () -> Void
}

protocol SplashViewModelInput {
    func getConfigs()
}

protocol SplashViewModelOutput {
    var title: String { get }
}

class SplashViewModel: SplashViewModelInput, SplashViewModelOutput {
    var title: String = ""
    private var useCase: FetchConfigsUseCase?
    private var closures: SplashViewModelClosures?
    
    init(useCase: FetchConfigsUseCase, closures: SplashViewModelClosures) {
        self.useCase = useCase
        self.closures = closures
    }
    
    func getConfigs() {
        self.useCase?.execute(requestValue: .init(query: .init()), cached: { (_) in
            
        }, completion: { (result) in
            self.closures?.closeSplash()
        })
    }
}
