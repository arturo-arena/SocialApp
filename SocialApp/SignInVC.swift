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
    ///////
    @IBOutlet weak var label11: UILabel!
    @IBOutlet weak var label22: UILabel!
    //////
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser?.uid != nil {
            performSegue(withIdentifier: "goToFeedVC", sender: self)
        }
    }
    
    @IBAction func fbLoginButton(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email, .userFriends], viewController: self) {
            loginResult in switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("$*$*$* User cancelled login")
            case .success( _, _, _):
                print("$*$*$* Logged in!")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(withCredential: credential)
                self.performSegue(withIdentifier: "goToFeedVC", sender: self)
                
            }
        }
    }
    
    func firebaseAuth(withCredential cred: AuthCredential) {
        Auth.auth().signIn(with: cred) { (user, error) in
            if error != nil {
                print("$*$*$* unable to authenticate with firebase: \(error.debugDescription)")
            } else {
                print("$*$*$* successfully authenticated with Firebase")
                if let user = user {
                    FirebaseDataService.ds.createFirebaseUser(uid: user.uid, userData: ["provider": cred.provider])
                }
            }
        }
    }
    @IBAction func signInBtn(_ sender: Any) {
        if let email = emailTxtFld.text, let password = passwordTxtFld.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("$*$*$* Email user authenticated with firebase")
                    if let user = user {
                        FirebaseDataService.ds.createFirebaseUser(uid: user.uid, userData: ["provider": user.providerID])
                    }
                    self.performSegue(withIdentifier: "goToFeedVC", sender: self)
                } else {
                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, err) in
                        if err != nil {
                            print("$*$*$* error authenticating with firebase using email: \(err.debugDescription)")
                        } else {
                            print("$*$*$* successfully created new user on firebase!")
                            if let user = user {
                                FirebaseDataService.ds.createFirebaseUser(uid: user.uid, userData: ["provider": user.providerID])
                            }
                            self.performSegue(withIdentifier: "goToFeedVC", sender: self)
                        }
                    })
                }
            })
        }
    }
    
    
//////
    @IBAction func checkbtn(_ sender: Any) {
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
    
    @IBAction func signOutBtn(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        try! Auth.auth().signOut()
    }
//////
}

