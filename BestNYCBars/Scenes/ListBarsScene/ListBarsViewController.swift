//
//  ListBarsViewController.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ListBarsDisplayLogic: class {
    func displayBars(viewModel: ListBars.List.ViewModel)
}

class ListBarsViewController: UIViewController, ListBarsDisplayLogic {
    var interactor: ListBarsBusinessLogic?
    var router: (NSObjectProtocol & ListBarsRoutingLogic & ListBarsDataPassing)?

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = ListBarsInteractor()
        let presenter = ListBarsPresenter()
        let router = ListBarsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        listBars()
    }
  
    // MARK: List bars
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var displayedBars = [ListBars.List.ViewModel.DisplayedBar]()
    
    func listBars() {
        interactor?.listBars()
    }
  
    func displayBars(viewModel: ListBars.List.ViewModel) {
        if viewModel.success {
            guard viewModel.displayedBars.count > 0 else { return }
            activityIndicatorView?.stopAnimating()
            displayedBars += viewModel.displayedBars
            self.tableView.reloadData()
        } else {
            handleError(errorTitle: viewModel.errorTitle, errorMessage: viewModel.errorMessage)
        }
    }
    
    // MARK: Handle error
    
    private func handleError(errorTitle: String?, errorMessage: String?) {
        activityIndicatorView?.stopAnimating()
        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListBarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListBarsCell", for: indexPath) as! ListBarsCell
        let displayedBar = displayedBars[indexPath.row]
        cell.thumbImageView?.setImageView(urlString: displayedBar.thumb)
        cell.name.text = displayedBar.name
        cell.costForTwo.text = displayedBar.costForTwo
        cell.stars.value = displayedBar.rating
        cell.accessibilityIdentifier = String(format:UITest.barTableViewCell.rawValue, indexPath.row)
        
        return cell
    }
}

extension ListBarsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == displayedBars.count - 10) {
            listBars()
        }
    }
}

