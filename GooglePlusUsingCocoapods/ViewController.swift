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
        
        // gid_signinSharedInstance?.clientID = "599280904951-9usr5as4773rkimklle3o6a08q3tui4i.apps.googleusercontent.com"
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
        
        print("GD DId Sign in, user : \(user)")
        
        
        gid_signinSharedInstance?.scopes = ["https://www.googleapis.com/auth/plus.login","https://www.googleapis.com/auth/plus.me"]
        
        if ((gid_signinSharedInstance?.hasAuthInKeychain) != nil) {
            // Signed in
            signInOnButton.isHidden = true
            signOutButton.isHidden = false
            disconnectButton.isHidden = false
            statusLabel.text =  "logged In"
            
            
            //let userId = user.userID as AnyObject // For client-side use only!
            //            let idToken = user.authentication.idToken as String  // Safe to send to the server
            //            let fullName = user.profile.name as String
            //            let givenName = user.profile.givenName as String
            //            let familyName = user.profile.familyName as String
            //            let email = user.profile.email as String
            //
            //            if(user.profile.hasImage){
            //
            //                print("profile image available")
            //
            //            }
            
            
            
            
            
        } else {
            print("Not signed in")
            signInOnButton.isHidden = false
            signOutButton.isHidden = true
            disconnectButton.isHidden = true
            statusLabel.text = "Google Sign in\niOS Demo"
        }
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            
            print("error nil")
            
            let userId = user.userID as String // For client-side use only!
            let idToken = user.authentication.idToken as String  // Safe to send to the server
            let fullName = user.profile.name as String
            let givenName = user.profile.givenName as String
            let familyName = user.profile.familyName as String
            let email = user.profile.email as String
            
            if(user.profile.hasImage){
                
                print("profile image available")
                
            }
            
            
            
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
        
        // profileDataDict = ["user_id":user.userID as AnyObject ,"id_token": user.authentication.idToken as AnyObject,"profile_name": user.profile.name as AnyObject,"given_name": user.profile.givenName as AnyObject,"family_name": user.profile.familyName as AnyObject,"email": user.profile.email as AnyObject, "profile_description": user.profile.description as AnyObject]
        // print(profileDataDict)
        
        
    }
    //    private func finishAuthorizationForUser(signInUser: GIDGoogleUser) {
    //
    //        let servicePlus = GTLServicePlus()
    //        servicePlus.authorizer = signInUser.authentication.fetcherAuthorizer()
    //        servicePlus.fetchObjectWithURL(NSURL(string: "https://www.googleapis.com/plus/v1/people/me")!, completionHandler: { (ticket, object, error) -> Void in
    //
    //            guard error == nil else {
    //                self.showUnsuccessfulLoginAlertWithMessage(error.description)
    //                return
    //            }
    //
    //            guard let user = object as? GTLObject else {
    //                self.showUnsuccessfulLoginAlertWithMessage("Bad user")
    //                return
    //            }
    //
    //            let userJson = NSDictionary(dictionary: user.JSON) as! [String: AnyObject]
    //
    //            if let names = userJson["name"] as? [String: String] {
    //                let lastName = names["familyName"]
    //                let firstName = names["givenName"]
    //                //...do something with these names
    //            }
    //        })
    //
    //    }
    
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

