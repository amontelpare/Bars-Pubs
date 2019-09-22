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
        }
        struct ViewModel {
            struct DisplayedBarOrPub {
                
            }
            
            let displayedBarsOrPubs: [DisplayedBarOrPub]
        }
    }
}
