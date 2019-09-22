//
//  ListBarsAndPubsRouter.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

@objc protocol ListBarsAndPubsRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ListBarsAndPubsDataPassing {
    var dataStore: ListBarsAndPubsDataStore? { get }
}

class ListBarsAndPubsRouter: NSObject, ListBarsAndPubsRoutingLogic, ListBarsAndPubsDataPassing {
    weak var viewController: ListBarsAndPubsViewController?
    var dataStore: ListBarsAndPubsDataStore?
  
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?) {
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation
    
    //func navigateToSomewhere(source: ListBarsAndPubsViewController, destination: SomewhereViewController) {
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ListBarsAndPubsDataStore, destination: inout SomewhereDataStore) {
    //  destination.name = source.name
    //}
}
