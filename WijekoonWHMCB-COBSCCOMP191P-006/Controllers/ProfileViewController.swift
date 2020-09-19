//
//  ProfileViewController.swift
//  WijekoonWHMCB-COBSCCOMP191P-006
//
//  Created by Chathura Wijekoon on 9/19/20.
//  Copyright © 2020 Chathura Wijekoon. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProPic: UIImageView!
    @IBOutlet weak var lblUserSince: UILabel!
    
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserAddress: UITextField!
    
    let db = Firestore.firestore()
    
    var documentId = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUser()
    }
    
    func loadUser() {
        if let email = Auth.auth().currentUser?.email {
            db.collection("users").whereField("email", isEqualTo: email)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        let document = querySnapshot!.documents[0]
                        
                        self.documentId = document.documentID
                        
                        if let name = document.data()["name"] as? String, let address = document.data()["address"] as? String, let userSince = document.data()["createdOn"] as? Timestamp, let bodyTemp = document.data()["temp"] as? String {
                            print(document.data())
                            self.navigationItem.title = name as? String
                            
                            self.txtUserName.text = name
                            self.txtUserAddress.text = address
                            self.lblUserSince.text = "\(userSince.dateValue().getFormattedDate(format: "MMM yyyy"))"
                            
                            let mf = MeasurementFormatter()
                            let temp = Measurement(value: Double(bodyTemp) ?? 0, unit: UnitTemperature.celsius)
                            mf.locale = Locale(identifier: "en_GB")
                            print(mf.string(from: temp))
                            self.lblCurrentTemp.text = "\(mf.string(from: temp))"
                        }
                    }
            }
        }
    }
    
    @IBAction func btnProfileUpdate(_ sender: Any) {
        if documentId != "", let name = txtUserName.text, let address = txtUserAddress.text {
            db.collection("users").document(documentId).updateData(["name": name, "address": address]) {error in
                if let err = error {
                    print(err)
                    
                    self.txtUserName.text = ""
                    self.txtUserAddress.text = ""
                    
                    return
                }
            }
        }

    }
}



extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

