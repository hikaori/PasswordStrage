//
//  AddAppViewController.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-11-12.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewAppViewController: UIViewController {

 
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    var isEditMode: Bool?
    var appRealm: AppRealm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // if appRealm is not nil ('PwTableViewCell' selected), this method run
        if let appRealm = appRealm {
            titleField.text = appRealm.title
            passwordField.text = appRealm.password
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddNewPassword(_ sender: Any) {
        print("add")
        let realm = try! Realm()
        let newApp = AppRealm()
        newApp.title = titleField.text!
        newApp.password = passwordField.text!
        print(newApp)
        try! realm.write() {
            realm.add(newApp)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
