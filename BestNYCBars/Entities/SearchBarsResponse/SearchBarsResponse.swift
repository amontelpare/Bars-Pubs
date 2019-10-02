//
//  SearchBarsResponse.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation

struct SearchBarsResponse {
    let resultsFound: Int
    let resultsStart: Int
    let resultsShown: Int
    let barsArrayOfDictionaries: [[String:Bar]]
}

extension SearchBarsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case resultsFound = "results_found"
        case resultsStart = "results_start"
        case resultsShown = "results_shown"
        case barsArrayOfDictionaries = "restaurants"
    }
}

extension SearchBarsResponse {
    var bars: [Bar] {
        get {
            let _bars = barsArrayOfDictionaries.flatMap {[Bar]($0.values)}
            return _bars
        }
    }
}
