//
//  SettingsViewController.swift
//  WijekoonWHMCB-COBSCCOMP191P-006
//
//  Created by Chathura Wijekoon on 9/18/20.
//  Copyright © 2020 Chathura Wijekoon. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    
    @IBAction func btnLogout(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            tabBarController?.selectedIndex = 0
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
