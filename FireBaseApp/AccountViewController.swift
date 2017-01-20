//
//  AccountViewController.swift
//  FireBaseApp
//
//  Created by Amerald on 11/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AccountViewController: UIViewController {

    @IBOutlet var UserEmail: UILabel!
    @IBOutlet var UserPassword: UILabel!
    
    var FBDataBase = FireBaseDataBase()
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    let userID: String=(FIRAuth.auth()?.currentUser?.uid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        FBDataBase.GetSpecificUser("Users", ItemNameOrId: userID, success: { (snapshot) -> () in

            self.UserEmail.text = snapshot.value!["email"] as? String
            self.UserPassword.text = snapshot.value! ["password"] as? String
        })
      
        FBDataBase.RetriveAllData({ (snapshot) -> () in
            
            print(snapshot.value as? [String : AnyObject])
        })
       
    }
 
    @IBAction func SignOut(sender: UIButton) {
        
        try! FIRAuth.auth()?.signOut()
        FBDataBase.RemoveSpecificUser("Online Users", ItemNameOrId
            :userID)
        print("User SignOut")

    }
}
