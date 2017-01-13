

//
//  FireBase.swift
//  FireBaseApp
//
//  Created by Amerald on 12/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class FireBase: NSObject {
 
    
    func CreateAuthenticatedUser(Uemail:String , Upassword:String, Shouldverify:Bool, completion: (NSError?) -> ())
    {
  
        [self.CreateUser(Uemail, Upassword: Upassword, Shouldverify: Shouldverify ){ (error) -> () in
            
            if error != nil{
                completion(error!)
            }
            
            }]
        
    }
    
   
    func CreateUser( Uemail:String , Upassword:String, Shouldverify:Bool , completion: (NSError?) -> ())
    {
        FIRAuth.auth()?.createUserWithEmail(Uemail, password: Upassword, completion: {
            (user,error) in
            if error != nil{
                completion(error!)
            }
            else
            {
                if Shouldverify
                {
                    [self.SendVerificationEmail(Uemail, Upassword: Upassword) { (error) -> () in
                        
                        if error != nil{
                            completion(error!)
                        }
                        
                        }]
                }
            }
         })
    }
    
    func SendVerificationEmail( Uemail:String , Upassword:String , completion: (NSError?) -> ())
    {
        FIRAuth.auth()?.currentUser?.sendEmailVerificationWithCompletion({ (error) in
            if let error = error {
               completion(error)
            }
        })
    }
    
    func SignIn(Uemail:String , Upassword:String , completion: (NSError?) -> ()) {
        
        FIRAuth.auth()?.signInWithEmail(Uemail, password: Upassword, completion: {
            (user,error) in
            if error != nil{
                completion(error!)
            }
            if self.IsVreifiedUser()
            {
                print("Signed In")
               
            }
        })

    }
    
    func IsVreifiedUser()-> Bool
    {
        var verify:Bool { return (FIRAuth.auth()?.currentUser?.emailVerified)!}
         return verify
    }
}


