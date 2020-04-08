//
//  LoginViewController.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var viewModel: LoginViewModel!
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let view = LoginViewController(nibName: "LoginViewController", bundle: nil)
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addBehaviors([BackButtonEmptyTitleNavigationBarBehavior()])
        
        bind(to: viewModel)
        
        viewModel.getConfigs()
        // Do any additional setup after loading the view.
    }
    
    private func bind(to viewModel: LoginViewModel) {
//        title = viewModel.title
//        overviewTextView.text = viewModel.overview
//        viewModel.posterImage.observe(on: self) { [weak self] in self?.posterImageView.image = $0.flatMap(UIImage.init) }
//        posterImageView.isHidden = viewModel.isPosterImageHidden
        viewModel.title.observe(on: self) { [weak self] in self?.descriptionLabel.text = $0 as String }
    }


    @IBAction func loginButtonPressed() {
        viewModel.loginButtinPress()
    }
}
