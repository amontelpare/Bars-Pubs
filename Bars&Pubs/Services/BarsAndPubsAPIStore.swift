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
        
        let url = URL(string: "\(baseSearchUrl)start=\(startAt)&category=\(category.rawValue)&count=\(count)&sort=\(sort)&order=\(order)&entity_id=280&entity_type=city")!
        var request = URLRequest(url: url)
        request.addValue(ApiAuth.value.rawValue, forHTTPHeaderField: ApiAuth.key.rawValue)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completionHandler{ throw ListBarsAndPubsStoreError.ServerError }
                    return
            }

            if let data = data, error == nil {
                do {
                    let decoder = JSONDecoder()
                    let searchBarsAndPubsResponse = try decoder.decode(SearchBarsAndPubsResponse.self, from: data)
                    completionHandler{ return searchBarsAndPubsResponse }
                } catch let error {
                    completionHandler{ throw ListBarsAndPubsStoreError.DecodeError(error.localizedDescription) }
                }
            } else {
                completionHandler{ throw ListBarsAndPubsStoreError.CannotFetch(response!.url!.absoluteString) }
            }
        })
        task.resume()
    }
}

