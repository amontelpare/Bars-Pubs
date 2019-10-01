//
//  UIImageViewDownloader.swift
//  Bars&Pubs
//
//  Created by Andrés Montelpare on 21/09/2019.
//  Copyright (c) 2019 Andrés Montelpare. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
        
    func setImageView(urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.setImageView(url: url)
        }
    }

    func setImageView(url: URL) {
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_imageIndicator?.startAnimatingIndicator()
        self.sd_setImage(with: url, placeholderImage: UIImage(named: "no-image"), options: [.delayPlaceholder, .allowInvalidSSLCertificates], completed: { (image, error, _, _) in
            self.sd_imageIndicator?.stopAnimatingIndicator()
        })
    }
}
