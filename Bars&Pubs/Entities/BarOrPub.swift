//
//  BarOrPub.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation

struct BarOrPub: Decodable {
    
    // MARK:
    let name: String
    let timings: String
    let cuisines: String
    let thumb: String
    let average_cost_for_two: Int
}

