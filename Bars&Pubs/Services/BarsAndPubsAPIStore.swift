//
//  BarsAndPubsAPIStore.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation

class BarsAndPubsAPIStore: ListBarsAndPubsStoreProtocol {
    let session = URLSession.shared
    let baseSearchUrl = "https://developers.zomato.com/api/v2.1/search?"
    
    // MARK: - CRUD operations - Inner closure
    
    func fetchBarsAndPubs(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsAndPubsResponse) -> Void) {
        
        let url = URL(string: "\(baseSearchUrl)start=\(startAt)&category=\(category.rawValue)&count=\(count)")!
        var request = URLRequest(url: url)
        request.addValue(ApiAuth.value.rawValue, forHTTPHeaderField: ApiAuth.key.rawValue)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            if let data = data, error == nil {
                do {
                    let decoder = JSONDecoder()
                    let searchBarsAndPubsResponse = try decoder.decode(SearchBarsAndPubsResponse.self, from: data)
                    completionHandler{ return searchBarsAndPubsResponse }
                    
                } catch let error {
                    completionHandler{ throw ListBarsAndPubsStoreError.CannotFetch("") }
                }
            } else {
                completionHandler{ throw ListBarsAndPubsStoreError.CannotFetch("") }
            }
        })
        task.resume()
    }
}

enum ApiAuth: String {
    case key = "user-key"
    case value = "afedf265c9253be3b47f0be8a4744c50"//"98946139a3526851e43b301a1832f3d7"
}
//afedf265c9253be3b47f0be8a4744c50
