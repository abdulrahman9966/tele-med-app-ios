//
//  DoctorRegisterViewController.swift
//  telm
//
//  Created by Abdul Rahman Mohammad on 3/5/18.
//  Copyright © 2018 Mohammad, Abdul Rahman. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DoctorRegisterViewController: UIViewController {
    
    
    var ref: DatabaseReference!

    
    @IBOutlet weak var fnameTextField: UITextField!
    
    
    @IBOutlet weak var doctorLabel: UILabel!
    
    @IBOutlet weak var lnameTextField: UITextField!

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var expTextField: UITextField!
    
    @IBOutlet weak var specTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func docRegisterBtn(_ sender: Any) {
        
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
                    let values = ["fname":self.fnameTextField.text,"lname":self.lnameTextField.text,"email": self.emailTextField.text,"password": self.passwordTextField.text,"exp":self.expTextField.text,"spec":self.specTextField.text,"type":self.doctorLabel.text]
                    usersReference.updateChildValues(values, withCompletionBlock:{ (err, ref)
                        in
                        
                        if err != nil{
                            print(err)
                            return
                        }
                        
                        print("saved doctor successfully into fire db")
                    })
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
