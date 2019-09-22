//
//  ListBarsAndPubsViewController.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import PaginatedTableView

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
  
    @IBOutlet weak var tableView: PaginatedTableView!
    var displayedBarsOrPubs = [ListBarsAndPubs.List.ViewModel.DisplayedBarOrPub]()
    
    func listBarsAndPubs() {
        interactor?.listBarsAndPubs()
    }
  
    func displayBarsAndPubs(viewModel: ListBarsAndPubs.List.ViewModel) {
        displayedBarsOrPubs = viewModel.displayedBarsOrPubs
        tableView?.reloadData()
    }
}
