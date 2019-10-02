//
//  BarsAPIStore.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation

class BarsAPIStore: ListBarsStoreProtocol {
    let session = URLSession.shared
    let baseSearchUrl = "https://developers.zomato.com/api/v2.1/search?"
    
    // MARK: - CRUD operations - Inner closure
    
    func fetchBars(category: Categories, sort: SortBy, order: SortOrder, count: Int, startAt: Int, completionHandler: @escaping (() throws -> SearchBarsResponse) -> Void) {
        
        let url = URL(string: "\(baseSearchUrl)start=\(startAt)&category=\(category.rawValue)&count=\(count)&sort=\(sort)&order=\(order)&entity_id=280&entity_type=city")!
        var request = URLRequest(url: url)
        request.addValue(ApiAuth.value.rawValue, forHTTPHeaderField: ApiAuth.key.rawValue)
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    completionHandler{ throw ListBarsStoreError.ServerError }
                    return
            }

            if let data = data, error == nil {
                do {
                    let decoder = JSONDecoder()
                    let searchBarsResponse = try decoder.decode(SearchBarsResponse.self, from: data)
                    completionHandler{ return searchBarsResponse }
                } catch let error {
                    completionHandler{ throw ListBarsStoreError.DecodeError(error.localizedDescription) }
                }
            } else {
                completionHandler{ throw ListBarsStoreError.CannotFetch(response!.url!.absoluteString) }
            }
        })
        task.resume()
    }
}

