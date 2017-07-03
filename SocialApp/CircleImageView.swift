//
//  CircleImageView.swift
//  SocialApp
//
//  Created by Arturo Arena on 2017-06-29.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = SHADOW_GRAY
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
    }
    
    

}
