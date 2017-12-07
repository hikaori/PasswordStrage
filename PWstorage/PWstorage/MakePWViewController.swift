//
//  MakePWViewController.swift
//  PWstorage
//
//  Created by kaori hirata on 2017-12-02.
//  Copyright © 2017 kaori hirata. All rights reserved.
//

import UIKit

class MakePWViewController: UIViewController {
    @IBOutlet weak var createdPW: UILabel!
    
    @IBOutlet weak var lenghtLabel: UILabel!
    var isIncludeUpper : Bool?
    var isIncludeNums : Bool?
    var isIncludeSymbols : Bool?
    
    var alphabets = "abcdefghijklmnopqrstuvwxyz"
    var numbers = "0123456789"
    var symbols = "?!%$#()"
    var base = "abcdefghijklmnopqrstuvwxyz"
    var seed = ""
    var pw = ""
    var sliderValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func IsIncludeUpperCase(_ sender: UISwitch) {
        if (sender.isOn){
            isIncludeUpper = true
        }
    }
    
    @IBAction func isIncludeNums(_ sender: UISwitch) {
        if (sender.isOn){
            isIncludeNums = true
        }
    }
    @IBAction func isIncludeSymbols(_ sender: UISwitch) {
        if (sender.isOn){
            isIncludeSymbols = true
        }
    }
    
    @IBAction func getLength(_ sender: UISlider) {
        sliderValue = Int(sender.value)
        lenghtLabel.text = String(sliderValue)
    }
    
    @IBAction func createPWButton(_ sender: Any) {
        seed = base
        if(isIncludeUpper!){ seed += alphabets.uppercased()}
        if(isIncludeNums!){ seed += numbers}
        if(isIncludeSymbols!){ seed += symbols}
        createPW()
    }
    
    
    func createPW(){
        pw = ""
        var length = sliderValue
        while (length > 0) {
            let rundamNum = arc4random_uniform(UInt32(seed.count))
            let index = seed.index(seed.startIndex, offsetBy: String.IndexDistance(rundamNum))
            pw += String(seed[index])
            length = length - 1
        }
        createdPW.text = pw
    }
    @IBAction func submitButton(_ sender: UIButton) {
        print("+++++")
//        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            let controller =  segue.destination as! AddNewAppViewController
        let controller = AddNewAppViewController()
            controller.passwordField.text = (createdPW.text)
            print("=====\(controller.passwordField.text)")
//        }
        dismiss(animated: true, completion: nil)
    }
    @IBAction func CancelButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
