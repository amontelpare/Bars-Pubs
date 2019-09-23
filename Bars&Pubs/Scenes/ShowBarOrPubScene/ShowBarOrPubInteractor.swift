//
//  ShowBarOrPubInteractor.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ShowBarOrPubBusinessLogic {
    func showMap()
}

protocol ShowBarOrPubDataStore {
    var barOrPub: BarOrPub! { get set }
}

class ShowBarOrPubInteractor: ShowBarOrPubBusinessLogic, ShowBarOrPubDataStore {
    var presenter: ShowBarOrPubPresentationLogic?
    var worker: ShowBarOrPubWorker?
    var barOrPub: BarOrPub!
  
    // MARK: Show map
  
    func showMap() {
        let response = ShowBarOrPub.ShowMap.Response(barOrPub: barOrPub)
        presenter?.presentMap(response: response)
    }
}
