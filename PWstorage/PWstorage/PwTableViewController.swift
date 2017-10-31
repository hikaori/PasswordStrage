//
//  PwTableViewController.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-10-30.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit

class PwTableViewController: UITableViewController {
    var app1 = App(title: "fb")
    var app2 = App(title: "twitter")
    var app3 = App(title: "linkdin")
    var apps = [App]()

    override func viewDidLoad() {
        super.viewDidLoad()
        apps.append(app1)
        apps.append(app2)
        apps.append(app3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apps.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PwTableViewCell else {
            fatalError("The dequeued cell is not an instance of PwTableViewCell.")
        }
        let app = apps[indexPath.row]
        cell.appName.text = app.title
        return cell
    }
}