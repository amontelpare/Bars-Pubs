//
//  ListBarsCell.swift
//  BestNYCBars
//
//  Created by Andrés Montelpare on 22/09/2019.
//  Copyright © 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import HCSStarRatingView

class ListBarsCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var costForTwo: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var stars: HCSStarRatingView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbImageView.image = nil
    }
}
