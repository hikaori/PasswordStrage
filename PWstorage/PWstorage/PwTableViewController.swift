//
//  PwTableViewController.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-10-30.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit
import RealmSwift

class PwTableViewController: UITableViewController {
    
    // Get the default Realm
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("start")
    }
    
    // reload tableView
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPW"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let appCollection = realm.objects(AppRealm.self)
                let app = appCollection[indexPath.row]
                let controller = segue.destination as! AddNewAppViewController
                // set selected data to 'appReam' propaty in AddAppViewController
                controller.appRealm = app
                controller.isEditMode = true
                controller.isClickedImage = false
                let index = indexPath.row
                controller.id = String(index)
            }
        }else if segue.identifier == "addNewPW" {
            let controller = segue.destination as! AddNewAppViewController
            controller.isEditMode = false
            controller.isClickedImage = false
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let appCollection = realm.objects(AppRealm.self)
        return appCollection.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PwTableViewCell else {
            fatalError("The dequeued cell is not an instance of PwTableViewCell.")
        }
        let appCollection = realm.objects(AppRealm.self)
        let app = appCollection[indexPath.row]
        cell.appName.text = app.title
        let image = UIImage(data:app.imageData! as Data)
        cell.imageForCell.image = image
        return cell
    }
    
    // Mark: delete selected item from tableview and realm data
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let appCollection = realm.objects(AppRealm.self)
            let app = appCollection[indexPath.row]
            print("app \(app)")
            try! realm.write() {
                realm.delete(app)
            }
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
}
