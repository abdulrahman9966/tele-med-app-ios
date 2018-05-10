//
//  PatientHomeViewController.swift
//  telm
//
//  Created by Mohammad, Abdul Rahman on 2/24/18.
//  Copyright © 2018 Mohammad, Abdul Rahman. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class PatientHomeViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource,UISearchResultsUpdating,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

   // let doctors: [String] = ["Abdul Rahman", "Maha Singh", "Sai Abhinav", "Karthik Reddy", "Salman Khan"]
 //   let docImages = [#imageLiteral(resourceName: "doctor.png"), #imageLiteral(resourceName: "doctor.png"), #imageLiteral(resourceName: "doctor.png"), #imageLiteral(resourceName: "doctor.png"),#imageLiteral(resourceName: "doctor.png")]
  //  let docInfo = ["Dermantologist","Pediatrist","Oncologist", "Neurologist","Pathalogist"]
  //  let docStatus = ["Available","Not Available","Available", "Not Available","Available"]

    
    var ref: DatabaseReference!

    struct Doctor{
        var name: String
        var spec: String
        var pic: String
        var status: String
    }
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    var doctors = [
        Doctor(name:"abdul",spec: "dermatologist",pic:"doctor.png", status: "Available"),
        Doctor(name:"rahman",spec: "pathologist",pic:"doctor.png", status: "Not Available"),
        Doctor(name:"maha",spec: "dermatologist",pic:"doctor.png", status: "Available"),
        Doctor(name:"singh",spec: "pediatrist",pic:"doctor.png", status: "Not Available"),
        Doctor(name:"sai",spec: "dermatologist",pic:"doctor.png", status: "Available"),
        Doctor(name:"abhinav",spec: "pathologist",pic:"doctor.png", status: "Available")
    ]
    let cellReuseIdentifier = "cell"

    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)

    var filteredDoctors = [Doctor]()
    
   
  //  @IBOutlet weak var searchBar: UISearchBar!
    
  
//var isSearching = false
    let picker = UIImagePickerController()


    override func viewDidLoad() {
        super.viewDidLoad()
       
        filteredDoctors = doctors
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        self.navigationItem.title = Auth.auth().currentUser?.email
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        
        let storageRef = Storage.storage().reference()
        let databaseRef = Database.database().reference()
        
        let userID = Auth.auth().currentUser?.uid
        databaseRef.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            print(value)
            let username = value?["fname"] as? String ?? ""
            self.profileNameLabel.text = username
            //let user = User(username: username)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // Register the table view cell class and its reuse id
   //     self.tableView.register(DoctorCustomTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
      
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
      //  searchBar.delegate = self
        //searchBar.returnKeyType = UIReturnKeyType.done
        
        let logoutBtn = UIBarButtonItem(barButtonSystemItem: .action,target: self, action: #selector(logOutButton) )
        self.navigationItem.rightBarButtonItem = logoutBtn
        
    
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.filteredDoctors.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:DoctorCustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! DoctorCustomTableViewCell
        
        // set the text from the data model
        cell.doctorImage.image = UIImage(named:self.filteredDoctors[indexPath.row].pic)
        cell.doctorCellLabel.text = self.filteredDoctors[indexPath.row].name
        cell.doctorInfo.text = self.filteredDoctors[indexPath.row].spec
        cell.statusLabel.text =  self.filteredDoctors[indexPath.row].status

        if cell.statusLabel.text == "Available" {
            cell.statusLabel.textColor = UIColor.green
        }
        else{
            cell.statusLabel.textColor = UIColor.red
        }
        

        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
       // performSegue(withIdentifier: "patientHome2DoctorDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "patientHome2DoctorDetail" ,
            let detailDoctorVC = segue.destination as? DoctorDetailViewController ,
            let indexPath = self.tableView.indexPathForSelectedRow {
            let selectedDocName = filteredDoctors[indexPath.row].name
            let selectedDocSpec = filteredDoctors[indexPath.row].spec
            let selectedDocStatus = filteredDoctors[indexPath.row].status
            let selectedDocPic = filteredDoctors[indexPath.row].pic
            detailDoctorVC.docName = selectedDocName
            detailDoctorVC.docSpecl = selectedDocSpec
            detailDoctorVC.docStat = selectedDocStatus
            detailDoctorVC.docImg = selectedDocPic
            
        }
    }


    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        if searchController.searchBar.text! == "" {
            filteredDoctors = doctors
        } else {
            // Filter the results
            filteredDoctors = doctors.filter { $0.spec.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.tableView.reloadData()
    }
  
    
    
    @IBAction func logOutButton(sender: UIButton) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                navigationController?.popToRootViewController(animated:true)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
  
    @IBAction func editProfilePic(_ sender: Any) {
        
       
        self.present(picker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profilePic.image = chosenImage  
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
