

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
    

    func AddUserInDB(Uemail:String , Upassword:String, UserId:String)
    {
        ref = FIRDatabase.database().reference()
        ref.child("Users").child(UserId).setValue(["Email":Uemail, "Password":Upassword])
    }
}
