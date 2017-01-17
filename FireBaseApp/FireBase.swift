
//  FireBase.swift
//  FireBaseApp
//
//  Created by Amerald on 12/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FireBase: NSObject {
 
    
    func CreateAuthenticatedUser(Uemail:String , Upassword:String, Shouldverify:Bool, completion: (NSError?) -> ())
    {
  
        [self.CreateUser(Uemail, Upassword: Upassword){ (error) -> () in
            
            if error != nil
            {
                completion(error! as NSError?)
            }
            else{
                completion(nil)
                if Shouldverify
                {
                    [self.SendVerificationEmail(Uemail, Upassword: Upassword) { (error) -> () in
                        
                        if error != nil
                        {
                            completion(error! as NSError?)
                        }
                        else{
                            completion(nil)
                        }
                        
                        }]
                }
            }
         }]
    }

    func CreateUser( Uemail:String , Upassword:String , completion: (NSError?) -> ())
    {
        FIRAuth.auth()?.createUserWithEmail(Uemail, password: Upassword, completion: {
            (user,error) in
           if error != nil
                {
                    completion(error! as NSError?)
            }
            else{
                completion(nil)
           
                }
         })
    }
    
    func SendVerificationEmail( Uemail:String , Upassword:String , completion: (NSError?) -> ())
    {
        FIRAuth.auth()?.currentUser?.sendEmailVerificationWithCompletion({ (error) in
            if error != nil
            {
                completion(error! as NSError?)
            }
            else{
                completion(nil)
            }
        })
    }
    
    func SignIn(Uemail:String , Upassword:String , completion: (NSError?) -> ()) {
        
        FIRAuth.auth()?.signInWithEmail(Uemail, password: Upassword, completion: {
            (user,error) in
            if error != nil
            {
                completion(error! as NSError?)
            }
            else{
                completion(nil)
            }
            
        })

    }
    
    func IsVreifiedUser()-> Bool
    {
        var verify:Bool { return (FIRAuth.auth()?.currentUser?.emailVerified)!}
         return verify
        
    }
}


