//
//  ListBarsAndPubsModels.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

enum ListBarsAndPubs {
  
    // MARK: Use cases
  
    enum List {
        struct Response {
            let barsAndPubs: [BarOrPub]
            let storeError: ListBarsAndPubsStoreError?
        }
        
        struct ViewModel {
            struct DisplayedBarOrPub {
                let name: String
                let thumb: String
                let rating: CGFloat
                let costForTwo: String
            }
            
            var success: Bool
            var errorTitle: String?
            var errorMessage: String?
            let displayedBarsOrPubs: [DisplayedBarOrPub]
        }
    }
}
