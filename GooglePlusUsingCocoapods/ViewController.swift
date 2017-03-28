//
//  ViewController.swift
//  GooglePlusUsingCocoapods
//
//  Created by Pushpam Group on 25/03/17.
//  Copyright © 2017 Pushpam Group. All rights reserved.

import UIKit
import GoogleSignIn
import Google


class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    @IBOutlet var signOutButton: UIButton!
    @IBOutlet var disconnectButton: UIButton!
    @IBOutlet var signInOnButton: GIDSignInButton!
    @IBOutlet var statusLabel: UILabel!
    
    var gid_signinSharedInstance = GIDSignIn.sharedInstance()
    var profileDataDict = [String: AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gid_signinSharedInstance?.delegate = self
        gid_signinSharedInstance?.uiDelegate = self
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    //GIDSignInUIDelegate Methods
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!){
        
        //UIActivityIndicatorView.stopAnimating()
        
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!){
        
        self.present(viewController, animated: true, completion: nil)
        
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    //GIDSignInDelegate Methods
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!){
        
        
        if ((gid_signinSharedInstance?.hasAuthInKeychain) != nil) {
            // Signed in
            signInOnButton.isHidden = true
            signOutButton.isHidden = false
            disconnectButton.isHidden = false
            statusLabel.text =  "logged In"
            
        } else {
            print("Not signed in")
            signInOnButton.isHidden = false
            signOutButton.isHidden = true
            disconnectButton.isHidden = true
            statusLabel.text = "Google Sign in\niOS Demo"
        }
        
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            
            let userId :String = String(user.userID) as String// For client-side use only!
            let idToken :String = user.authentication.idToken as String  // Safe to send to the server
            let fullName:String = user.profile.name as String
            let givenName: String = user.profile.givenName as String
            let familyName: String = user.profile.familyName as String
            let email: String = user.profile.email as String
            
            //Add to Dict
            profileDataDict = ["user_id":user.userID as AnyObject ,"id_token": user.authentication.idToken as AnyObject,"profile_name": user.profile.name as AnyObject,"given_name": user.profile.givenName as AnyObject,"family_name": user.profile.familyName as AnyObject,"email": user.profile.email as AnyObject, "profile_description": user.profile.description as AnyObject]
            
            print(profileDataDict)
            
            if(user.profile.hasImage){
                print("profile image available")                
            }
        } else {
            print("\(error.localizedDescription)")
        }
        
        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!){
        print("logged out")
        
    }
    
    //UIButton Actions
    @IBAction func signOutButtonClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        statusLabel.text = "Signed out."
        
    }
    @IBAction func disconnectButtonClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().disconnect()
        statusLabel.text = "Disconnecting."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

