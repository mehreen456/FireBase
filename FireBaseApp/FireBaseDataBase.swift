

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

    func AddUserInDB(DataBaseName:String, ItemNameOrId
        :String , DataToStore: Dictionary <String,NSObject>)
    {
        ref = FIRDatabase.database().reference()
        ref.child(DataBaseName).child(ItemNameOrId).setValue(DataToStore)
    }
    func RetriveAllData()
    {
        ref = FIRDatabase.database().reference()
        refHandle = ref.observeEventType(FIRDataEventType.Value, withBlock: {(snapshot) in
            
            let dataDict = snapshot.value as! [String: AnyObject]
            print(dataDict)
        })
    }
    
    func GetCurrentUser(DataBaseName:String, ItemNameOrId
        :NSObject , success:(AnyObject) -> ())
    {
        
        ref = FIRDatabase.database().reference()
        let userID: String=(FIRAuth.auth()?.currentUser?.uid)!
        ref.child(DataBaseName).child(userID).observeSingleEventOfType(.Value , withBlock: {(snapshot) in
            let dataDict = snapshot.value as! [String: AnyObject]
            success(dataDict)
        })
       
    }
}
