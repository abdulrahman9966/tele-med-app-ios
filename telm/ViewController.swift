//
//  ViewController.swift
//  telm
//
//  Created by Mohammad, Abdul Rahman on 2/24/18.
//  Copyright © 2018 Mohammad, Abdul Rahman. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var homeToggleBtn: UISegmentedControl!
    @IBOutlet weak var logInTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func homeToggle(_ sender: UISegmentedControl) {
        
        if homeToggleBtn.selectedSegmentIndex == 0{
            logInTitle.text = "Patient Login"
        }
        if homeToggleBtn.selectedSegmentIndex == 1{

            logInTitle.text = "Doctor Login"
            
        }
    }
    
    
    @IBAction func logInButton(_ sender: Any) {
        
        self.navigationController?.isNavigationBarHidden = false
        
        
        
        
        
        if homeToggleBtn.selectedSegmentIndex == 0{
            
            
            if self.emailTextField.text == "" || self.passwordTextField.text == "" {
                
                //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                
                let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    
                    if error == nil {
                        
                        //Print into the console if successfully logged in
                        print("You have successfully logged in")
                        
                        //Go to the HomeViewController if the login is sucessful
                        self.performSegue(withIdentifier: "login2PatientHome", sender: self)
                        
                    } else {
                        
                        //Tells the user that there is an error and then gets firebase to tell them the error
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        
        }
        else{
            if self.emailTextField.text == "" || self.passwordTextField.text == "" {
                
                //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
                
                let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    
                    if error == nil {
                        
                        //Print into the console if successfully logged in
                        print("You have successfully logged in")
                        
                        //Go to the HomeViewController if the login is sucessful
                        self.performSegue(withIdentifier: "logIn2DoctorHome", sender: self)
                        
                    } else {
                        
                        //Tells the user that there is an error and then gets firebase to tell them the error
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alertController.addAction(defaultAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            }
        
        }
        
        
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        self.navigationController?.isNavigationBarHidden = false
        if homeToggleBtn.selectedSegmentIndex == 0{
            performSegue(withIdentifier: "logIn2Register", sender: self)
        }
        else{
            if emailTextField.text == "Admin", passwordTextField.text == "Admin"{
                
                performSegue(withIdentifier: "logIn2DoctorRegister", sender: self)
            }
            else{
                
                let alertController = UIAlertController(title: "Error", message: "Only Admin can register Doctors", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true, completion: nil)
            
            }
        }
    }
}

