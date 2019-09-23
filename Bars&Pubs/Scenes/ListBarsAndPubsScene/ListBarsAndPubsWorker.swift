//
//  ListBarsAndPubsWorker.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

class ListBarsAndPubsWorker {
    var listBarsAndPubsStore: ListBarsAndPubsStoreProtocol
    
    init(listBarsAndPubsStore: ListBarsAndPubsStoreProtocol = BarsAndPubsAPIStore()) {
        self.listBarsAndPubsStore = listBarsAndPubsStore
    }
    
    func fetchBarsAndPubs(category: Categories = .barsAndPubs, sort: SortBy = .rating, order: SortOrder = .desc, count: Int = 15, startAt: Int, completionHandler:@escaping (() throws -> SearchBarsAndPubsResponse) -> Void) {
        listBarsAndPubsStore.fetchBarsAndPubs(category: category, sort: sort, order: order, count: count, startAt: startAt) { (searchBarsAndPubsResponse: () throws -> SearchBarsAndPubsResponse) -> Void in
            do {
                let searchBarsAndPubsResponse = try searchBarsAndPubsResponse()
                DispatchQueue.main.async {
                    completionHandler { return searchBarsAndPubsResponse }
                }
            } catch let error {
                DispatchQueue.main.async {
                    completionHandler { throw error }
                }
            }
        }
    }
}

protocol ListBarsAndPubsStoreProtocol {
    
    // MARK: CRUD operations - Inner closure
    
    func fetchBarsAndPubs(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsAndPubsResponse) -> Void)
}

// MARK: - Orders store CRUD operation errors

enum ListBarsAndPubsStoreError: Equatable, Error {
    case DecodeError(String)
    case ServerError
    case CannotFetch(String)
}

func ==(lhs: ListBarsAndPubsStoreError, rhs: ListBarsAndPubsStoreError) -> Bool
{
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    default: return false
    }
}
