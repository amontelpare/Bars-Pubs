//
//  ListBarsAndPubsViewController.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ListBarsAndPubsDisplayLogic: class {
    func displayBarsAndPubs(viewModel: ListBarsAndPubs.List.ViewModel)
}

class ListBarsAndPubsViewController: UIViewController, ListBarsAndPubsDisplayLogic {
    var interactor: ListBarsAndPubsBusinessLogic?
    var router: (NSObjectProtocol & ListBarsAndPubsRoutingLogic & ListBarsAndPubsDataPassing)?

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
        let interactor = ListBarsAndPubsInteractor()
        let presenter = ListBarsAndPubsPresenter()
        let router = ListBarsAndPubsRouter()
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
        listBarsAndPubs()
    }
  
    // MARK: List bars and pubs
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var displayedBarsOrPubs = [ListBarsAndPubs.List.ViewModel.DisplayedBarOrPub]()
    
    func listBarsAndPubs() {
        interactor?.listBarsAndPubs()
    }
  
    func displayBarsAndPubs(viewModel: ListBarsAndPubs.List.ViewModel) {
        if viewModel.success {
            guard viewModel.displayedBarsOrPubs.count > 0 else { return }
            activityIndicatorView?.stopAnimating()
            displayedBarsOrPubs += viewModel.displayedBarsOrPubs
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

extension ListBarsAndPubsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedBarsOrPubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListBarsAndPubsCell", for: indexPath) as! ListBarsAndPubsCell
        let displayedBarOrPub = displayedBarsOrPubs[indexPath.row]
        cell.thumbImageView?.setImageView(urlString: displayedBarOrPub.thumb)
        cell.name.text = displayedBarOrPub.name
        cell.costForTwo.text = displayedBarOrPub.costForTwo
        cell.stars.value = displayedBarOrPub.rating
        
        return cell
    }
}

extension ListBarsAndPubsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == displayedBarsOrPubs.count - 10) {
            listBarsAndPubs()
        }
    }
}

