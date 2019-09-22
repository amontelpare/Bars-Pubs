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
    var startIndexForService: Int = 0
  
    // MARK: List bars and pubs
  
    func listBarsAndPubs() {
        guard worker == nil else { return }
        worker = ListBarsAndPubsWorker()
        worker?.fetchBarsAndPubs(startAt: startIndexForService, completionHandler: { (searchBarsAndPubsResponse) in
            do {
                let searchBarsAndPubsResponse = try searchBarsAndPubsResponse()
                let response = ListBarsAndPubs.List.Response(barsAndPubs: searchBarsAndPubsResponse.barsAndPubs)
                self.presenter?.presentBarsAndPubs(response: response)
                self.startIndexForService += searchBarsAndPubsResponse.barsAndPubs.count
            } catch let error {
                
            }
            self.worker = nil
        })
    }
}
