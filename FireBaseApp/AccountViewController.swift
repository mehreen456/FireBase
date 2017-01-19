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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        refHandle = ref.observeEventType(FIRDataEventType.Value, withBlock: {(snapshot) in
         
            let dataDict = snapshot.value as! [String: AnyObject]
            print(dataDict)
        })
        
        let userID: String=(FIRAuth.auth()?.currentUser?.uid)!
        FBDataBase.GetCurrentUser("Users", ItemNameOrId: userID, success: { (snapshot) -> () in
            
            let email = snapshot.value!["name"] as! String
            let password = snapshot.value!["addedByUser"] as! String
            self.UserEmail.text = email
            self.UserPassword.text = password

            
        })
       
    }

    
    @IBAction func SignOut(sender: UIButton) {
        
        try! FIRAuth.auth()?.signOut()
        print("User SignOut")

    }
}
