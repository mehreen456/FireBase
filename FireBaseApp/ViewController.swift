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
      let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navController = self.navigationController
        
       
    }

    @IBAction func SignIn(_ sender: UIButton) {
    
    
     Fvc.SignIn(self.EmailField.text!, Upassword: self.PasswordField.text!) { (error) -> () in
        
        if error != nil
         {
              print(error!.localizedDescription)
         }
         else {
            
            
               if self.Fvc.IsVreifiedUser()
               {
                    print("Signed In")
                    self.performSegue(withIdentifier: "Go", sender: self)
               }
            
               else{
                self.alertView("Email address not verified", Message: "Please verify your email address to  continue.")
   
            }
            }
        }
        

    }
    @IBAction func SignUpButton(_ sender: UIButton) {
        
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

    func alertView (_ Title:String, Message:String)
    {
        let alertController = UIAlertController(title:Title ,
            message: Message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        alertController.addAction(UIAlertAction(title: "OKAY",
            style: UIAlertActionStyle.default,
            handler: nil)
        )
    
        self.present(alertController, animated: true, completion: nil)
      //  self.navigationController?.present(alertController, animated: true, completion: nil)
    }

}

