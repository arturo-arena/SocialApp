//
//  TopMargrin.swift
//  SocialApp
//
//  Created by Arturo on 2017-06-18.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit

class TopMargrin: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = SHADOW_GRAY
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        
        
    }

}
