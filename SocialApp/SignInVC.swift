//
//  SignInVC.swift
//  SocialApp
//
//  Created by Arturo on 2017-06-18.
//  Copyright © 2017 Arturo Arena. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var label11: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func fbLoginButton(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email, .userFriends], viewController: self) {
            loginResult in switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login")
            case .success( _, _, _):
                print("Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(withCredential: credential)
                
            }
        }
    }
    
    func firebaseAuth(withCredential cred: AuthCredential) {
        Auth.auth().signIn(with: cred) { (user, error) in
            if error != nil {
                print("unable to authenticate with firebase: \(error.debugDescription)")
            } else {
                print("successfully authenticated with Firebase")
            }
        }
    }

    @IBAction func checkbtn(_ sender: Any) {
        if let accessToken =  AccessToken.current {
            label11.text = "Signed In"
        } else {
            label11.text = "Not Signed In"
        }
    }
}

