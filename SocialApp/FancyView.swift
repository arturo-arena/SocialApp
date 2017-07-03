//
//  FancyView.swift
//  SocialApp
//
//  Created by Arturo Arena on 2017-06-27.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit

class FancyView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = SHADOW_GRAY
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
        
    }
    
}
