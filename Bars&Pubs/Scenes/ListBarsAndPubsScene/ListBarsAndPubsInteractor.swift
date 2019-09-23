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
    var barsAndPubs: [BarOrPub] { get set }
}

class ListBarsAndPubsInteractor: ListBarsAndPubsBusinessLogic, ListBarsAndPubsDataStore {
    var presenter: ListBarsAndPubsPresentationLogic?
    var worker: ListBarsAndPubsWorker?
    var ratingWorker: RatingWorker! = RatingWorker()
    var startIndexForService: Int = 0
    var barsAndPubs = [BarOrPub]()
  
    // MARK: List bars and pubs
  
    func listBarsAndPubs() {
        guard worker == nil else { return }
        worker = ListBarsAndPubsWorker()
        worker?.fetchBarsAndPubs(startAt: startIndexForService, completionHandler: { (searchBarsAndPubsResponse) in
            do {
                let searchBarsAndPubsResponse = try searchBarsAndPubsResponse()
                var barsAndPubs = searchBarsAndPubsResponse.barsAndPubs
                barsAndPubs = self.roundBarsAndPubsRatings(barsAndPubs: barsAndPubs)
                let response = ListBarsAndPubs.List.Response(barsAndPubs: barsAndPubs)
                self.presenter?.presentBarsAndPubs(response: response)
                self.barsAndPubs += barsAndPubs
                self.startIndexForService += barsAndPubs.count
            } catch let error {
                
            }
            self.worker = nil
        })
    }
    
    // Private methods
    
    private func roundBarsAndPubsRatings(barsAndPubs: [BarOrPub]) -> [BarOrPub] {
        let _barsAndPubs: [BarOrPub] = barsAndPubs.map({ (barOrPub) in
            var barOrPub = barOrPub
            barOrPub.roundRating(ratingRounded: self.ratingWorker!.roundToDisplayStars(rating: barOrPub.rating.aggregateRatingCGFloat))
            return barOrPub
        })
        
        return _barsAndPubs
    }
}
