//
//  DoctorHomeViewController.swift
//  telm
//
//  Created by Mohammad, Abdul Rahman on 2/24/18.
//  Copyright © 2018 Mohammad, Abdul Rahman. All rights reserved.
//

import UIKit

class DoctorHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let logoutBtn = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(logoutButton) )
        self.navigationItem.rightBarButtonItem = logoutBtn

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    @IBAction func logoutButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated:true)
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
