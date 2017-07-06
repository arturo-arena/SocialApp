//
//  Post.swift
//  SocialApp
//
//  Created by Arturo Arena on 2017-07-03.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _caption: String!
    private var _imageUrl: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: DatabaseReference!
    
    var caption: String {
        return _caption
    }
    
    var imageUrl: String {
        return _imageUrl
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(postKey: String, postData: [String: AnyObject]) {
        self._postKey = postKey
        
        if let caption = postData["Caption"] as? String {
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["Likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = FirebaseDataService.ds.REF_POSTS.child(_postKey)
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = likes - 1
        }
        _postRef.child("Likes").setValue(_likes)
    }
    
}
