//
//  ListBarsAndPubsPresenter.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ListBarsAndPubsPresentationLogic {
    func presentBarsAndPubs(response: ListBarsAndPubs.List.Response)
}

class ListBarsAndPubsPresenter: ListBarsAndPubsPresentationLogic {
    weak var viewController: ListBarsAndPubsDisplayLogic?
  
    // MARK: List bars and pubs
  
    func presentBarsAndPubs(response: ListBarsAndPubs.List.Response) {
        var displayedBarsOrPubs = [ListBarsAndPubs.List.ViewModel.DisplayedBarOrPub]()
        for a in response.barsAndPubs {
            let barOrPub = ListBarsAndPubs.List.ViewModel.DisplayedBarOrPub(name: a.name, thumb: a.thumb, rating: a.rating.aggregateRatingCGFloat)
            displayedBarsOrPubs.append(barOrPub)
        }
        
        let viewModel = ListBarsAndPubs.List.ViewModel(displayedBarsOrPubs: displayedBarsOrPubs)
        viewController?.displayBarsAndPubs(viewModel: viewModel)
    }
}
