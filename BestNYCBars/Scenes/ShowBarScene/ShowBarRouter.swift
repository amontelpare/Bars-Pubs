//
//  ShowBarRouter.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

@objc protocol ShowBarRoutingLogic {
}

protocol ShowBarDataPassing {
    var dataStore: ShowBarDataStore? { get }
}

class ShowBarRouter: NSObject, ShowBarRoutingLogic, ShowBarDataPassing {
    weak var viewController: ShowBarViewController?
    var dataStore: ShowBarDataStore?
}
