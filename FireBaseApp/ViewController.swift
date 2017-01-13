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
import FirebaseDatabase

class ViewController: UIViewController{

    @IBOutlet var EmailField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    let Fvc=FireBase()
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      ref = FIRDatabase.database().reference()
      let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navController = self.navigationController
        
       
    }

    @IBAction func SignIn(sender: UIButton) {
    
    
     Fvc.SignIn(self.EmailField.text!, Upassword: self.PasswordField.text!) { (error) -> () in
        
        if error != nil
         {
              print(error!.localizedDescription)
         }
         else {
            
               if self.Fvc.IsVreifiedUser()
               {
                    print("Signed In")
                    self.performSegueWithIdentifier("Go", sender: self)
               }
            }
        }
        
     //   [self.alertView("Email address not verified", Message: "Please verify your email address to  continue.")]

    }
    @IBAction func SignUpButton(sender: UIButton) {
        
        Fvc.CreateAuthenticatedUser(self.EmailField.text!, Upassword: self.PasswordField.text!, Shouldverify: true){ (error) -> () in
            if error != nil
            {
                print(error!.localizedDescription)
            }
            else {
                print("User Created")
            }
        }

    //    [self.alertView("Email address verification", Message: "We have sent you an email that contains a link - you must click this link before you can continue.")]
        
    }

    func alertView (Title:String, Message:String)
    {
        let alertController = UIAlertController(title:Title ,
            message: Message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        alertController.addAction(UIAlertAction(title: "OKAY",
            style: UIAlertActionStyle.Default,
            handler: nil)
        )
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.navController.presentViewController(alertController, animated: true, completion: nil)
    }

}

