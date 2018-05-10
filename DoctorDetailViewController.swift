//
//  DoctorDetailViewController.swift
//  telm
//
//  Created by Abdul Rahman Mohammad on 2/25/18.
//  Copyright © 2018 Mohammad, Abdul Rahman. All rights reserved.
//

import UIKit


class DoctorDetailViewController: UIViewController {
    

    @IBOutlet weak var docImageView: UIImageView!
    
    @IBOutlet weak var docLabel: UILabel!
    @IBOutlet weak var docSpec: UILabel!
    
    @IBOutlet weak var docStatus: UILabel!
    
    @IBOutlet weak var MakeCallBtn: UIButton!
    
    var docName: String?
    var docSpecl :String?
    var docStat :String?
    var docImg :String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        docLabel.text = docName
        docSpec.text = docSpecl
        docStatus.text = docStat
        if docStat == "Available"{
            docStatus.textColor = UIColor.green
            MakeCallBtn.isHidden = false
        }else{
            docStatus.textColor = UIColor.red
            MakeCallBtn.isHidden = true

        }
        
        docImageView.image = UIImage(named: self.docImg!)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func callButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "doctorDetail2Appointment", sender: self)
    }
    


}
