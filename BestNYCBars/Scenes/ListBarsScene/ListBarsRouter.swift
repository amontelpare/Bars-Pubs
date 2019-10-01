//
//  ListBarsRouter.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

@objc protocol ListBarsRoutingLogic {
    func routeToShowBar(segue: UIStoryboardSegue?)
}

protocol ListBarsDataPassing {
    var dataStore: ListBarsDataStore? { get }
}

class ListBarsRouter: NSObject, ListBarsRoutingLogic, ListBarsDataPassing {
    weak var viewController: ListBarsViewController?
    var dataStore: ListBarsDataStore?
  
    // MARK: Routing
    
    func routeToShowBar(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! ShowBarViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToShowBar(source: dataStore!, destination: &destinationDS)
        }
    }

    // MARK: Passing data
    
    func passDataToShowBar(source: ListBarsDataStore, destination: inout ShowBarDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        destination.bar = source.bars[selectedRow!]
    }
}
