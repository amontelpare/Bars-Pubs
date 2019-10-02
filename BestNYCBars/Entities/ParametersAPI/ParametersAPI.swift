//
//  ParametersAPI.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import Foundation

enum Categories: String {
    case bars = "11"
}

enum SortBy: String {
    case rating = "rating"
}

enum SortOrder: String {
    case desc = "desc"
    case asc = "asc"
}

enum ApiAuth: String {
    case key = "user-key"
    case value = "afedf265c9253be3b47f0be8a4744c50"//"98946139a3526851e43b301a1832f3d7"
}
