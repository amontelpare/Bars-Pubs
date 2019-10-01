//
//  ShowBarModels.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import CoreLocation

enum ShowBar {
  
    // MARK: Use cases
  
    enum ShowMap {
        struct Response {
            let bar: Bar
        }
        
        struct ViewModel {
            struct DisplayedBar {
                let name: String
                let latitude: Double
                let longitude: Double
            }
            
            let displayedBar: DisplayedBar
        }
    }
    
    enum ShowDetails {
        struct Response {
            let bar: Bar
        }
        
        struct ViewModel {
            struct DisplayedBar {
                let timings: String
                let cuisines: String
            }
            
            let displayedBar: DisplayedBar
        }
    }
}
