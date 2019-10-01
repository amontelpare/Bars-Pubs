//
//  ListBarsAndPubsRouter.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

@objc protocol ListBarsAndPubsRoutingLogic {
    func routeToShowBarOrPub(segue: UIStoryboardSegue?)
}

protocol ListBarsAndPubsDataPassing {
    var dataStore: ListBarsAndPubsDataStore? { get }
}

class ListBarsAndPubsRouter: NSObject, ListBarsAndPubsRoutingLogic, ListBarsAndPubsDataPassing {
    weak var viewController: ListBarsAndPubsViewController?
    var dataStore: ListBarsAndPubsDataStore?
  
    // MARK: Routing
    
    func routeToShowBarOrPub(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowBarOrPubViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowBarOrPub(source: dataStore!, destination: &destinationDS)
        }
    }

    // MARK: Passing data
    
    func passDataToShowBarOrPub(source: ListBarsAndPubsDataStore, destination: inout ShowBarOrPubDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.barOrPub = source.barsAndPubs[selectedRow!]
    }
}
