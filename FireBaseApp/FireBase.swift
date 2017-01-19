
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
 
    
    func CreateAuthenticatedUser(Uemail:String , Upassword:String,Shouldverify:Bool, Success:(String) -> (), Failure: (NSError) -> ())
        {
             [self.CreateUser(Uemail, Upassword: Upassword, success:{ (userId) -> () in
                
                Success(userId)
                
                if Shouldverify{
                    
                    [self.SendVerificationEmail(Uemail, Upassword: Upassword) { (error) -> () in
                        
                        if error != nil{
                            Failure((error! as NSError?)!)}
                        }]
                }
                },
                
                failure: { (error) -> () in
                    Failure(error)
                })]
    }

    func CreateUser( Uemail:String , Upassword:String  , success:(String) -> (), failure: (NSError) -> ())
    {
        FIRAuth.auth()?.createUserWithEmail(Uemail, password: Upassword, completion: {
            (user,error) in
           if error == nil{
              success((user?.uid)!)
            }
           else{
               failure ((error! as NSError?)!)
            }
         })
    }
    
    func SendVerificationEmail( Uemail:String , Upassword:String , Error: (NSError?) -> ())
    {
        FIRAuth.auth()?.currentUser?.sendEmailVerificationWithCompletion({ (error) in
            if error != nil
            {
                Error(error! as NSError?)
            }
            else{
                Error(nil)
            }
        })
    }
    
    func SignIn(Uemail:String , Upassword:String ,success:(Bool) -> (), failure: (NSError) -> ()) {
        
        FIRAuth.auth()?.signInWithEmail(Uemail, password: Upassword, completion: {
            (user,error) in
            if error == nil
            {
                success(true)
            }
            else{
                failure((error! as NSError?)!)
            }
            
        })

    }
    
    func IsVreifiedUser()-> Bool
    {
        var verify:Bool { return (FIRAuth.auth()?.currentUser?.emailVerified)!}
         return verify
        
    }
}


