//
//  RoundCornersBtn.swift
//  SocialApp
//
//  Created by Arturo on 2017-06-19.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit

class RoundCornersBtn: UIButton {

    override func awakeFromNib() {
        layer.shadowColor = SHADOW_GRAY
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 2.0
    }

}
