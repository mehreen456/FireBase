

//
//  FireBaseDataBase.swift
//  FireBaseApp
//
//  Created by Amerald on 18/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FireBaseDataBase: NSObject {

     var ref: FIRDatabaseReference!
     var refHandle: UInt! 

    func AddUserInDB(DataToStore: Dictionary <String,NSObject>)
    {
        ref = FIRDatabase.database().reference()
        
        ref.child("Users").child("UserInfo").setValue(DataToStore)
        //Ref.child("Users").child(UserId).setValue(["Email":Uemail, "Password":Upassword])
    }
    
    func RetriveAllData()
    {
        ref = FIRDatabase.database().reference()
        refHandle = ref.observeEventType(FIRDataEventType.Value, withBlock: {(snapshot) in
            
            let dataDict = snapshot.value as! [String: AnyObject]
            print(dataDict)
        })
    }
    
    func GetCurrentUser()
    {
        ref = FIRDatabase.database().reference()
        let userID: String=(FIRAuth.auth()?.currentUser?.uid)!
        ref.child("Users").child(userID).observeSingleEventOfType(.Value , withBlock: {(snapshot) in
          
            let email = snapshot.value!["Email"] as! String
            let password = snapshot.value!["Password"] as! String
            
        })
    }
}
