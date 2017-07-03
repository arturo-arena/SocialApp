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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // class variables
    var loginManager: LoginManager!
    // IBOutlets
    @IBOutlet weak var tableVIew: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // class variable inits
        loginManager = LoginManager()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
    }
    // IBActions
    @IBAction func logOutBtn(_ sender: Any) {
        loginManager.logOut()
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
}
