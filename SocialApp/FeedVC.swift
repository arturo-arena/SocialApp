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
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageOut: CircleImageView!
    @IBOutlet weak var captionField: UITextField!
    // arrays
    var posts = [Post]()
    // BOOL check variables
    var imageSelected = false

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
        
        FirebaseDataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            self.posts.removeAll()
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
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell {

            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                cell.configureCell(post: post, img: img)
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
        } else {
            return PostCell()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImageOut.image = image
            imageSelected = true
        } else {
            print("*$*$*$* a valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // IBActions
    @IBAction func postBtn(_ sender: Any) {
        guard let caption = captionField.text, caption != "" else {
            print("*$*$*$* caption must be entered")
            return
        }
        guard let img = addImageOut.image, imageSelected == true else {
            print("*$*$*$* An image must be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpeg"
            
            FirebaseDataService.ds.REF_POST_IMAGES.child(imgUid).putData(imgData, metadata: metaData, completion: { (metadata, error) in
                if error != nil {
                    print("*$*$*$* unable to upload image to firebase storage")
                } else {
                    print("*$*$*$* successfully uploaded image to firebase storage")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    if let url = downloadUrl {
                        self.postToFirebase(imgUrl: url)
                    }
                }
            })
            
        }
    }
    
    func postToFirebase(imgUrl: String) {
        posts.removeAll()
        let post: [String:Any] = [
        "Caption": captionField.text!,
        "imageUrl": imgUrl,
        "Likes": 0
        ]
        
        let firebasePost = FirebaseDataService.ds.REF_POSTS.childByAutoId()
        firebasePost.setValue(post)
        
        captionField.text = ""
        addImageOut.image = UIImage(named: "add-image")
        imageSelected = false
    }
    
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
