//
//  ViewController.swift
//  FireBaseApp
//
//  Created by Amerald on 10/01/2017.
//  Copyright © 2017 attribe. All rights reserved.
//

import UIKit

import Firebase
import FirebaseAuth


class ViewController: UIViewController{

    @IBOutlet var EmailField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    let Fvc=FireBase()
    let FBDataBase=FireBaseDataBase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func SignIn(sender: UIButton)  {
    
        Fvc.SignIn(self.EmailField.text!, Upassword: self.PasswordField.text!, success: {
            (success) -> () in
            
            self.FBDataBase.findUsers("Users",key:"email" ,text: "asdqwe@gmail.com", success:{(snapshot) -> () in
               
            })
            if success
            {
           // if self.Fvc.IsVreifiedUser()
          //  {
                print("Signed In")
                let userID: String=(FIRAuth.auth()?.currentUser?.uid)!
                self.FBDataBase.AddOnlineUsers("Online Users",ItemNameOrId: userID,DataToStore: self.DataToStore())
                self.performSegueWithIdentifier("Go", sender: self)
         /*   }
            else
            {
                [self.alertView("Email address not verified", Message: "Please verify your email address to  continue.")]
            }*/
            }},
            
            failure: { (error) -> () in
                print(error.localizedDescription)
               [self.alertView("Error!", Message:error.localizedDescription)]
        })
}

    @IBAction func SignUpButton(sender: UIButton) {
        
        Fvc.CreateAuthenticatedUser(self.EmailField.text!, Upassword: self.PasswordField.text!,
            
            Shouldverify: false, Success: { (userId) -> () in
              print(userId)
              // [self.alertView("Email address verification", Message: "We have sent you an email that contains a link - you must click this link before you can continue.")]
            
                self.FBDataBase.AddUserInDB("Users",ItemNameOrId: userId,DataToStore: self.DataToStore())
            },
            
            Failure: { (error) -> () in
                print(error.localizedDescription)
            [self.alertView("Error!", Message:error.localizedDescription)]
        })
}

    func alertView (Title:String, Message:String)
    {
        let alertController = UIAlertController(title:Title ,
            message: Message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alertController.addAction(UIAlertAction(title: "OKAY", style: UIAlertActionStyle.Default,
            handler: nil)
        )
       self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func DataToStore() -> Dictionary <String,NSObject>
    {
        let dic:[String:NSObject] = [
            
            "email": self.EmailField.text!,
            "password": self.PasswordField.text!,
            
        ]
        return dic
    }
    
  }

