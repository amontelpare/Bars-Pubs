//
//  ListBarsWorker.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

class ListBarsWorker {
    var listBarsStore: ListBarsStoreProtocol
    
    init(listBarsStore: ListBarsStoreProtocol = BarsAPIStore()) {
        self.listBarsStore = listBarsStore
    }
    
    func fetchBars(category: Categories = .bars, sort: SortBy = .rating, order: SortOrder = .desc, count: Int = 15, startAt: Int, completionHandler:@escaping (() throws -> SearchBarsResponse) -> Void) {
        listBarsStore.fetchBars(category: category, sort: sort, order: order, count: count, startAt: startAt) { (searchBarsResponse: () throws -> SearchBarsResponse) -> Void in
            do {
                let searchBarsResponse = try searchBarsResponse()
                DispatchQueue.main.async {
                    completionHandler { return searchBarsResponse }
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler { throw error }
                }
            }
        }
    }
}

protocol ListBarsStoreProtocol {
    
    // MARK: CRUD operations - Inner closure
    
    func fetchBars(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsResponse) -> Void)
}

// MARK: - Orders store CRUD operation errors

enum ListBarsStoreError: Equatable, Error {
    case DecodeError(String)
    case ServerError
    case CannotFetch(String)
}

func ==(lhs: ListBarsStoreError, rhs: ListBarsStoreError) -> Bool
{
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    default: return false
    }
}
