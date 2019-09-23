//
//  ShowBarOrPubRouter.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit

@objc protocol ShowBarOrPubRoutingLogic {
}

protocol ShowBarOrPubDataPassing {
    var dataStore: ShowBarOrPubDataStore? { get }
}

class ShowBarOrPubRouter: NSObject, ShowBarOrPubRoutingLogic, ShowBarOrPubDataPassing {
    weak var viewController: ShowBarOrPubViewController?
    var dataStore: ShowBarOrPubDataStore?
}
