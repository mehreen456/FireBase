

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
    
    func RetriveAllData(success:(FIRDataSnapshot) -> ())
    {
        ref = FIRDatabase.database().reference()
        refHandle = ref.observeEventType(FIRDataEventType.Value, withBlock: {(snapshot) in

            success(snapshot)

        })
    }
    
    func GetSpecificUser(DataBaseName:String, ItemNameOrId
        :NSObject , success:(FIRDataSnapshot) -> ())
    {
        
        ref = FIRDatabase.database().reference()
        ref.child(DataBaseName).child(ItemNameOrId as! String).observeSingleEventOfType(.Value , withBlock: {(snapshot) in
        
            success(snapshot)
        })
    }
    
    func AddOnlineUsers(DataBaseName:String, ItemNameOrId
        :String , DataToStore: Dictionary <String,NSObject>){
            
        ref = FIRDatabase.database().referenceWithPath(DataBaseName)
        let currentUserRef = ref.child(ItemNameOrId)
        currentUserRef.setValue(DataToStore)
        currentUserRef.onDisconnectRemoveValue()
    }
    
    func RemoveSpecificUser(DataBaseName:String, ItemNameOrId :NSObject){
        
        FIRDatabase.database().referenceWithPath(DataBaseName).child(ItemNameOrId as! String).removeValue()
    }
    
    func findUsers(DataBaseName:String,key: String,text: String , success:(FIRDataSnapshot) -> ()){
        
         FIRDatabase.database().reference().child(DataBaseName).queryOrderedByChild(key).queryEqualToValue(text).observeEventType(.Value, withBlock: { snapshot in
            
            let a = snapshot.value!["password"] as? String
            print(a)

          success(snapshot)
        })
    }
    
}
