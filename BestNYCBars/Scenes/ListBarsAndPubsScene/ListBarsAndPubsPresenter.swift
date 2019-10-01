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
        for barOrPub in response.barsAndPubs {
            let displayedBarOrPub = ListBarsAndPubs.List.ViewModel.DisplayedBarOrPub(name: barOrPub.name, thumb: barOrPub.thumb, rating: barOrPub.rating.aggregateRatingCGFloat, costForTwo: "Cost for two: \(barOrPub.averageCostForTwo)")
            displayedBarsOrPubs.append(displayedBarOrPub)
        }
        
        var errorTitle: String? = nil
        var errorMessage: String? = nil
        var success: Bool = true
        if let error = response.storeError {
            handleError(error:error, success: &success, errorTitle: &errorTitle, errorMessage: &errorMessage)
        }
        
        let viewModel = ListBarsAndPubs.List.ViewModel(success: success, errorTitle: errorTitle, errorMessage: errorMessage, displayedBarsOrPubs: displayedBarsOrPubs)
        viewController?.displayBarsAndPubs(viewModel: viewModel)
    }
    
    // MARK: Handle error
    
    private func handleError(error: ListBarsAndPubsStoreError, success: inout Bool, errorTitle: inout String?, errorMessage: inout String?) {
        switch error {
        case .ServerError:
            success = false
            errorTitle = "Error"
            errorMessage = "Error fetching data"
        default:
            success = false
            errorTitle = "Error"
            errorMessage = "Unknown error"
        }
    }
}
