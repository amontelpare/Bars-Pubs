//
//  ListBarsModels.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

enum ListBars {
  
    // MARK: Use cases
  
    enum List {
        struct Response {
            let bars: [Bar]
            let storeError: ListBarsStoreError?
        }
        
        struct ViewModel {
            struct DisplayedBar {
                let name: String
                let thumb: String
                let rating: CGFloat
                let costForTwo: String
            }
            
            var success: Bool
            var errorTitle: String?
            var errorMessage: String?
            let displayedBars: [DisplayedBar]
        }
    }
}
