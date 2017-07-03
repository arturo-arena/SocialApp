//
//  PostCell.swift
//  SocialApp
//
//  Created by Arturo Arena on 2017-07-02.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var ProfileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var numberOfLikeLbl: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
