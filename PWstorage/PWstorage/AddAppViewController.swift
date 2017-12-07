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
    var isClickedImage: Bool?
    var appRealm: AppRealm?
    var picker:UIImagePickerController?=UIImagePickerController()
    var imageData:NSData?
    var id : String?
    
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
            
            // set appRealm data to AddNewAppViewController's propaty
            self.id = appRealm.id
            
            //
            
            // this method for update image when user try to change image from previouse image
            if(isClickedImage!){
                // selected image will be set self.imageData
            }else{
               imageView.image = imageFromData
               self.imageData = appRealm.imageData
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Gallery(_ sender: Any) {
        isClickedImage = true
        openGallary()
    }
    @IBAction func AddNewPassword(_ sender: Any) {
        let realm = try! Realm()
        let newApp = AppRealm()
        
        newApp.title = titleField.text!
        newApp.password = passwordField.text!
        newApp.imageData = imageData
        newApp.id = UUID().uuidString
        print(newApp)
        
        try! realm.write() {
            guard let isEdit = isEditMode else { return }
            if isEdit {
                newApp.id = self.id!
                newApp.imageData = self.imageData
                realm.add(newApp, update: true)
                navigationController?.popViewController(animated: true)
            } else {
                realm.add(newApp)
                dismiss(animated: true, completion: nil)
            }
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
