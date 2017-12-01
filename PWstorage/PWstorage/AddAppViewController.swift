//
//  AddAppViewController.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-11-12.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewAppViewController: UIViewController,UIImagePickerControllerDelegate,UIPopoverControllerDelegate,UINavigationControllerDelegate {

 
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var isEditMode: Bool?
    var appRealm: AppRealm?
    var picker:UIImagePickerController?=UIImagePickerController()
    var imageData:NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate=self
        imageView.image = UIImage(named: "picture.png")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // if appRealm is not nil ('PwTableViewCell' selected), this method run
        if let appRealm = appRealm {
            titleField.text = appRealm.title
            passwordField.text = appRealm.password
            let imageFromData = UIImage(data: appRealm.imageData! as Data)
            imageView.image = imageFromData
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Gallery(_ sender: Any) {
        openGallary()
    }
    @IBAction func AddNewPassword(_ sender: Any) {
        print("add")
        let realm = try! Realm()
        let newApp = AppRealm()
        newApp.title = titleField.text!
        newApp.password = passwordField.text!
        newApp.imageData = imageData
        print(newApp)
        try! realm.write() {
            realm.add(newApp)
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: UIButton) {
        guard let isEdit = isEditMode else { return }
        if isEdit {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    
//ImagePickerView Delegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.contentMode = .scaleAspectFit
        imageView.image = chosenImage
        imageData = NSData(data: UIImagePNGRepresentation(chosenImage)!)
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
