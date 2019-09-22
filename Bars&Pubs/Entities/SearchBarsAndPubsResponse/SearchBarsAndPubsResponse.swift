//
//  SearchBarsAndPubsResponse.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation

struct SearchBarsAndPubsResponse: Decodable {
    let resultsFound: Int
    let resultsStart: Int
    let resultsShown: Int
    let barsAndPubsArrayOfDictionaries: [[String:BarOrPub]]
    
    enum CodingKeys: String, CodingKey{
        case resultsFound = "results_found"
        case resultsStart = "results_start"
        case resultsShown = "results_shown"
        case barsAndPubsArrayOfDictionaries = "restaurants"
    }
}

extension SearchBarsAndPubsResponse {
    var barsAndPubs: [BarOrPub] {
        get {
            let _barsAndPubs = barsAndPubsArrayOfDictionaries.flatMap {[BarOrPub]($0.values)}
            return _barsAndPubs
        }
    }
}
