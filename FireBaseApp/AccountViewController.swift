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
    
    var ref: FIRDatabaseReference!
    var refHandle: UInt!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        refHandle = ref.observeEventType(FIRDataEventType.Value, withBlock: {(snapshot) in
         
            let dataDict = snapshot.value as! [String: AnyObject]
            print(dataDict)
        })
        
        let userID: String=(FIRAuth.auth()?.currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEventOfType(.Value , withBlock: {(snapshot) in
            let email = snapshot.value!["Email"] as! String
            let password = snapshot.value!["Password"] as! String
            self.UserEmail.text = email
            self.UserPassword.text = password
            
        })
    }

    
    @IBAction func SignOut(sender: UIButton) {
        
        try! FIRAuth.auth()?.signOut()
        print("User SignOut")

    }
}
