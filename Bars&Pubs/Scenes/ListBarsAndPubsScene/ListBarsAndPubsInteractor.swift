//
//  ListBarsAndPubsInteractor.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ListBarsAndPubsBusinessLogic {
    func listBarsAndPubs()
}

protocol ListBarsAndPubsDataStore {
    //var name: String { get set }
}

class ListBarsAndPubsInteractor: ListBarsAndPubsBusinessLogic, ListBarsAndPubsDataStore {
    var presenter: ListBarsAndPubsPresentationLogic?
    var worker: ListBarsAndPubsWorker?
    //var name: String = ""
  
    // MARK: List bars and pubs
  
    func listBarsAndPubs() {
        worker = ListBarsAndPubsWorker()
        worker?.fetchBarsAndPubs(completionHandler: { (barsAndPubs) in
            
        })
    
        let response = ListBarsAndPubs.List.Response()
        presenter?.presentBarsAndPubs(response: response)
    }
}
