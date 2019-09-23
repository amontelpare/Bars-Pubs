//
//  ShowBarOrPubPresenter.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ShowBarOrPubPresentationLogic {
    func presentMap(response: ShowBarOrPub.ShowMap.Response)
    func presentDetails(response: ShowBarOrPub.ShowDetails.Response)
}

class ShowBarOrPubPresenter: ShowBarOrPubPresentationLogic {
    weak var viewController: ShowBarOrPubDisplayLogic?
  
    // MARK: Show map
  
    func presentMap(response: ShowBarOrPub.ShowMap.Response) {
        let barOrPub = response.barOrPub
        let latitude = Double(barOrPub.location.latitude)!
        let longitude = Double(barOrPub.location.longitude)!
        let displayedBarOrPub = ShowBarOrPub.ShowMap.ViewModel.DisplayedBarOrPub(name: barOrPub.name, latitude: latitude, longitude: longitude)
        let viewModel = ShowBarOrPub.ShowMap.ViewModel(displayedBarOrPub: displayedBarOrPub)
        viewController?.displayMap(viewModel: viewModel)
    }
    
    // MARK: Show details
    
    func presentDetails(response: ShowBarOrPub.ShowDetails.Response) {
        let barOrPub = response.barOrPub
        let displayedBarOrPub = ShowBarOrPub.ShowDetails.ViewModel.DisplayedBarOrPub(timings: barOrPub.timings, cuisines: barOrPub.cuisines)
        let viewModel = ShowBarOrPub.ShowDetails.ViewModel(displayedBarOrPub: displayedBarOrPub)
        viewController?.displayDetails(viewModel: viewModel)
    }
}
