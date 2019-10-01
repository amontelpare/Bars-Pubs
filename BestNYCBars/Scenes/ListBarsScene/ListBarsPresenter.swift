//
//  ListBarsPresenter.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ListBarsPresentationLogic {
    func presentBars(response: ListBars.List.Response)
}

class ListBarsPresenter: ListBarsPresentationLogic {
    weak var viewController: ListBarsDisplayLogic?
  
    // MARK: List bars
  
    func presentBars(response: ListBars.List.Response) {
        var displayedBars = [ListBars.List.ViewModel.DisplayedBar]()
        for bar in response.bars {
            let displayedBar = ListBars.List.ViewModel.DisplayedBar(name: bar.name, thumb: bar.thumb, rating: bar.rating.aggregateRatingCGFloat, costForTwo: "Cost for two: \(bar.averageCostForTwo)")
            displayedBars.append(displayedBar)
        }
        
        var errorTitle: String? = nil
        var errorMessage: String? = nil
        var success: Bool = true
        if let error = response.storeError {
            handleError(error:error, success: &success, errorTitle: &errorTitle, errorMessage: &errorMessage)
        }
        
        let viewModel = ListBars.List.ViewModel(success: success, errorTitle: errorTitle, errorMessage: errorMessage, displayedBars: displayedBars)
        viewController?.displayBars(viewModel: viewModel)
    }
    
    // MARK: Handle error
    
    private func handleError(error: ListBarsStoreError, success: inout Bool, errorTitle: inout String?, errorMessage: inout String?) {
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
