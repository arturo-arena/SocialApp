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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // class variables
    var loginManager: LoginManager!
    var imagePicker: UIImagePickerController!
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageOut: CircleImageView!
    // arrays
    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // class variable inits
        loginManager = LoginManager()
        imagePicker = UIImagePickerController()
        // image picker
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        setTableViewData()
    }
    
    func setTableViewData() {
        posts.removeAll()
        
        FirebaseDataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots {
                    if let postsDict = snap.value as? [String:AnyObject] {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postsDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell {
            let post = self.posts[indexPath.row]
            cell.configureCell(post: post)
            return cell
        } else {
            return PostCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImageOut.image = image
        } else {
            print("*$*$*$* a valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // IBActions
    
    @IBAction func addImageBtn(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        loginManager.logOut()
        do { try Auth.auth().signOut() } catch {
            print("could not sign out")
        }
        dismiss(animated: true, completion: nil)
    }
}
