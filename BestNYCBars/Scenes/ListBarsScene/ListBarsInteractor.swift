//
//  ListBarsInteractor.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

protocol ListBarsBusinessLogic {
    func listBars()
}

protocol ListBarsDataStore {
    var bars: [Bar] { get set }
}

class ListBarsInteractor: ListBarsBusinessLogic, ListBarsDataStore {
    var presenter: ListBarsPresentationLogic?
    var worker: ListBarsWorker! = ListBarsWorker()
    var ratingWorker: RatingWorker! = RatingWorker()
    var startIndexForService: Int = 0
    var bars = [Bar]()
  
    // MARK: List bars 
  
    func listBars() {
        worker?.fetchBars(startAt: startIndexForService, completionHandler: { (searchBarsResponse) in
            do {
                let searchBarsResponse = try searchBarsResponse()
                var bars = searchBarsResponse.bars
                bars = self.roundBarsRatings(bars: bars)
                let response = ListBars.List.Response(bars: bars, storeError: nil)
                self.presenter?.presentBars(response: response)
                self.bars += bars
                self.startIndexForService += bars.count
            } catch let error {
                let response = ListBars.List.Response(bars: [], storeError: error as? ListBarsStoreError)
                self.presenter?.presentBars(response: response)
            }
            self.worker = ListBarsWorker()
        })
        worker = nil
    }
    
    // Private methods
    
    private func roundBarsRatings(bars: [Bar]) -> [Bar] {
        let _bars: [Bar] = bars.map({ (bar) in
            var bar = bar
            bar.roundRating(ratingRounded: self.ratingWorker!.roundToDisplayStars(rating: bar.rating.aggregateRatingCGFloat))
            return bar
        })
        
        return _bars
    }
}
