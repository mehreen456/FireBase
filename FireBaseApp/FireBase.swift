

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
 
    
    func CreateAuthenticatedUser(_ Uemail:String , Upassword:String, Shouldverify:Bool, completion: @escaping (NSError?) -> ())
    {
  
        self.CreateUser(Uemail, Upassword: Upassword, Shouldverify: Shouldverify ){ (error) -> () in
            
            if error != nil
            {
           completion(error! as NSError?)
            }
            else{
                completion(nil)
            }
            }
        
    }
    
   
    func CreateUser( _ Uemail:String , Upassword:String, Shouldverify:Bool , completion: @escaping (NSError?) -> ())
    {
        FIRAuth.auth()?.createUser(withEmail: Uemail, password: Upassword, completion: {
            (user,error) in
            if error != nil
            {
            completion(error! as NSError?)
            }
            else{
                completion(nil)
            }
                if Shouldverify
                {
                    self.SendVerificationEmail(Uemail, Upassword: Upassword) { (error) -> () in
                        if error != nil
                        {
                        completion(error! as NSError?)
                        }
                        }
                }
            
         })
    }
    
    func SendVerificationEmail( _ Uemail:String , Upassword:String , completion: @escaping (NSError?) -> ())
    {
        FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: { (error) in
            if error != nil
            {
                completion(error! as NSError?)
            }
            else{
                completion(nil)
            }
        })
    }
    
    func SignIn(_ Uemail:String , Upassword:String , completion: @escaping (NSError?) -> ()) {
        
        FIRAuth.auth()?.signIn(withEmail: Uemail, password: Upassword, completion: {
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
        var verify:Bool { return (FIRAuth.auth()?.currentUser?.isEmailVerified)!}
         return verify
    }
}


