//
//  RegisterViewController.swift
//  telm
//
//  Created by Mohammad, Abdul Rahman on 2/24/18.
//  Copyright © 2018 Mohammad, Abdul Rahman. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage

class RegisterViewController: UIViewController {
    
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var lnameTextField: UITextField!
    
    @IBOutlet weak var fnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var patientLabel: UILabel!
    var userType:String = "patient"
    
    var email = String()
    var pass = String()
    var fname = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.text! = self.email
        passwordTextField.text! = self.pass
        print(email)
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func registerButton(_ sender: UIButton) {
        
        
       
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                
                
                
                if error == nil {
                    print("You have successfully signed up")
                    
                    
                                        
                    
                    self.ref = Database.database().reference(fromURL: "https://telm-ad923.firebaseio.com/")
                    
                    let usersReference = self.ref.child("users").child((user?.uid)!)
                    let values = ["fname":self.fnameTextField.text,"lname":self.lnameTextField.text,"email":self.emailTextField.text,"password":self.passwordTextField.text,"age":self.ageTextField.text,"phone":self.phoneTextField.text,"type": self.patientLabel.text ]
                    usersReference.updateChildValues(values, withCompletionBlock:{ (err, ref)
                        in
                        
                        if err != nil{
                            print(err)
                            return
                        }
                        
                        print("saved user successfully into fire db")
                    })
                    
                    //Goes to the Setup page which lets the user take a photo for their profile picture and also chose a username
                    self.performSegue(withIdentifier: "register2PatientHome", sender: self)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    
    }
   

}
