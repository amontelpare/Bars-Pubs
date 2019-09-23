//
//  ShowBarOrPubModels.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import CoreLocation

enum ShowBarOrPub {
  
    // MARK: Use cases
  
    enum ShowMap {
        
        struct Response {
            let barOrPub: BarOrPub
        }
        
        struct ViewModel {
            struct DisplayedBarOrPub {
                let name: String
                let latitude: Double
                let longitude: Double
            }
            
            let displayedBarOrPub: DisplayedBarOrPub
        }
    }
    
    enum ShowDetails {
        
        struct Response {
            let barOrPub: BarOrPub
        }
        
        struct ViewModel {
            struct DisplayedBarOrPub {
                let timings: String
                let cuisines: String
            }
            
            let displayedBarOrPub: DisplayedBarOrPub
        }
    }

}
