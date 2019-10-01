//
//  ShowBarPresenter.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ShowBarPresentationLogic {
    func presentMap(response: ShowBar.ShowMap.Response)
    func presentDetails(response: ShowBar.ShowDetails.Response)
}

class ShowBarPresenter: ShowBarPresentationLogic {
    weak var viewController: ShowBarDisplayLogic?
  
    // MARK: Show map
  
    func presentMap(response: ShowBar.ShowMap.Response) {
        let bar = response.bar
        let latitude = Double(bar.location.latitude)!
        let longitude = Double(bar.location.longitude)!
        let displayedBar = ShowBar.ShowMap.ViewModel.DisplayedBar(name: bar.name, latitude: latitude, longitude: longitude)
        let viewModel = ShowBar.ShowMap.ViewModel(displayedBar: displayedBar)
        viewController?.displayMap(viewModel: viewModel)
    }
    
    // MARK: Show details
    
    func presentDetails(response: ShowBar.ShowDetails.Response) {
        let bar = response.bar
        let displayedBar = ShowBar.ShowDetails.ViewModel.DisplayedBar(timings: bar.timings, cuisines: bar.cuisines)
        let viewModel = ShowBar.ShowDetails.ViewModel(displayedBar: displayedBar)
        viewController?.displayDetails(viewModel: viewModel)
    }
}
