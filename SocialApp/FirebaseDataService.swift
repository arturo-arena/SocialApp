//
//  FirebaseDataService.swift
//  SocialApp
//
//  Created by Arturo Arena on 2017-07-03.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE = Database.database().reference()

let STORAGE_BASE = Storage.storage().reference()

class FirebaseDataService {
    
    static let ds = FirebaseDataService()
    
    // Database Reference
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("Posts")
    private var _REF_USERS = DB_BASE.child("Users")
    
    // Storage Reference
    private var _REF_POST_IMAGES = STORAGE_BASE.child("post-pics")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: DatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_USER_CURRENT: DatabaseReference {
        let uid = Auth.auth().currentUser?.uid
        let user = REF_USERS.child(uid!)
        return user
    }
    
    var REF_POST_IMAGES: StorageReference {
        return _REF_POST_IMAGES
    }
    
    
    func createFirebaseUser(uid: String, userData: [String:String]) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
}
