//
//  SplashViewController.swift
//  ExampleMVVM
//
//  Created by Tatevik Tovmasyan on 4/8/20.
//

import UIKit

final class SplashViewController: UIViewController, StoryboardInstantiable, Alertable {
    
    private var viewModel: SplashViewModel!
    
    private var moviesTableViewController: MoviesListTableViewController?
    private var searchController = UISearchController(searchResultsController: nil)
    
    static func create(with viewModel: SplashViewModel) -> SplashViewController {
        let view = SplashViewController(nibName: "SplashViewController", bundle: nil)
        view.viewModel = viewModel
        return view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = viewModel.screenTitle
//        emptyDataLabel.text = viewModel.emptyDataTitle
        addBehaviors([BackButtonEmptyTitleNavigationBarBehavior()])
        
        bind(to: viewModel)
        
        viewModel.getConfigs()
//        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: SplashViewModel) {
//        viewModel.items.observe(on: self) { [weak self] in self?.moviesTableViewController?.items = $0 }
//        viewModel.query.observe(on: self) { [weak self] in self?.updateSearchController(query: $0) }
//        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
//        viewModel.loadingType.observe(on: self) { [weak self] _ in self?.updateViewsVisibility() }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        searchController.isActive = false
    }
    
    private func updateSearchController(query: String) {
//        searchController.isActive = false
//        searchController.searchBar.text = query
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: MoviesListTableViewController.self),
            let destinationVC = segue.destination as? MoviesListTableViewController {
            moviesTableViewController = destinationVC
//            moviesTableViewController?.viewModel = viewModel
//            moviesTableViewController?.posterImagesRepository = posterImagesRepository
        }
    }

    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
//        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    private func updateViewsVisibility() {
//        emptyDataLabel.isHidden = true
//        moviesListContainer.isHidden = true
//        suggestionsListContainer.isHidden = true
        LoadingView.hide()

//        switch viewModel.loadingType.value {
//        case .fullScreen: LoadingView.show()
//        case .nextPage: moviesListContainer.isHidden = false
//        case .none: updateMoviesListVisibility()
//        }
        updateQueriesSuggestionsVisibility()
    }
    
    private func updateMoviesListVisibility() {
//        guard !viewModel.isEmpty else {
//            emptyDataLabel.isHidden = false
//            return
//        }
//        moviesListContainer.isHidden = false
    }

    private func updateQueriesSuggestionsVisibility() {
//        guard searchController.searchBar.isFirstResponder else {
//            viewModel.closeQueriesSuggestions()
//            return
//        }
//        viewModel.showQueriesSuggestions()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
