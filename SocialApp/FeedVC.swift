//
//  FeedVC.swift
//  SocialApp
//
//  Created by Arturo Arena on 2017-06-27.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit
import Firebase
import FacebookCore
import FBSDKLoginKit
import FacebookLogin

class FeedVC: UIViewController {
    @IBOutlet weak var label22: UILabel!
    @IBOutlet weak var label11: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    ////////
    @IBAction func checkBtn(_ sender: Any) {
        if AccessToken.current != nil {
            label11.text = "Signed In"
        } else {
            label11.text = "Not Signed In"
        }
        if Auth.auth().currentUser?.uid != nil {
            label22.text = "Logged in"
        } else {
            label22.text = "Logged Out"
        }
    }
    ///////
}
