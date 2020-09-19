//
//  TempViewController.swift
//  WijekoonWHMCB-COBSCCOMP191P-006
//
//  Created by Chathura Wijekoon on 9/18/20.
//  Copyright © 2020 Chathura Wijekoon. All rights reserved.
//

import UIKit
import Firebase

class TempViewController: UIViewController {
    
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var txtUpdateTemp: UITextField!
    
    let db = Firestore.firestore()
    
    var documentId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadUser()
        
        if Auth.auth().currentUser == nil {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCloseTemp(_ sender: Any) {
        //navigationController?.popViewController(animated: true)
         tabBarController?.selectedIndex = 0
//        self.dismiss(animated: true, completion: nil)
//        navigationController?.popToRootViewController(animated: true)
        print("test")
    }
    
    func loadUser() {
        lblTemp.text = "Fetching....."
        lblTime.text = "Fetching....."
        
        if let email = Auth.auth().currentUser?.email {
            db.collection("users").whereField("email", isEqualTo: email)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        let document = querySnapshot!.documents[0]
                        
                        self.documentId = document.documentID
                        
                        if let temp = document.data()["temp"], let lastModified = document.data()["lastModified"] {
                            if let timestamp = lastModified as? Timestamp, let tempC = temp as? String {
                                self.lblTime.text = "\(timestamp.dateValue())"
                                self.lblTemp.text = "\(tempC) C"
                            }
                        } else {
                            self.lblTemp.text = "Not Updated"
                            self.lblTemp.text = "Not Updated"
                        }
                    }
            }
        }
    }

    @IBAction func updateTemp(_ sender: Any) {
        if documentId != "", let temp = txtUpdateTemp.text {
            db.collection("users").document(documentId).updateData(["temp": temp, "lastModified": Date()]) {error in
                if let err = error {
                    print(err)
                    return
                }
                self.lblTemp.text = "\(temp) C"
                self.lblTime.text = "\(Date())"
                self.txtUpdateTemp.text = ""
            }
        }
    }
}
