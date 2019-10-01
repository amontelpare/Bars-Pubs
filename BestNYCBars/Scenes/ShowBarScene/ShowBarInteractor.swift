//
//  ShowBarInteractor.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ShowBarBusinessLogic {
    func showMap()
    func showDetails()
}

protocol ShowBarDataStore {
    var bar: Bar! { get set }
}

class ShowBarInteractor: ShowBarBusinessLogic, ShowBarDataStore {
    var presenter: ShowBarPresentationLogic?
    var worker: ShowBarWorker?
    var bar: Bar!
  
    // MARK: Show map
  
    func showMap() {
        let response = ShowBar.ShowMap.Response(bar: bar)
        presenter?.presentMap(response: response)
    }

    // MARK: Show details
    
    func showDetails() {
        let response = ShowBar.ShowDetails.Response(bar: bar)
        presenter?.presentDetails(response: response)
    }
}
