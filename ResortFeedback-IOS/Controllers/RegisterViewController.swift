//
//  RegisterViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/5/22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var regUserTextField: UITextField!
    @IBOutlet weak var regPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        //CHECK USER INPUT FIRST
        if regUserTextField.text! == "" || regPasswordTextField.text! == "" {
            
            showAlertDialog(dtype : "Error",  msg : "Please provide username and/or password.", style : "alert", controller: "")
            
        }
        
        //CHECK AVAILABILITY
        let isUnique = DBManager.inst.checkUserAvailability(u: regUserTextField.text!)
        
        switch isUnique {
            
            case 0:
                //ADD DATA
                let isSuccess = DBManager.inst.addData(u: regUserTextField.text!, p: regPasswordTextField.text!)
                
                if isSuccess == true {
                    
                    UserData.userInfo = regUserTextField.text!
                    showAlertDialog(dtype: "Alert", msg: "Account Successfully Created", style: "alert", controller : r.registerSegue)
                    
                    //print("Under Construction!")
                    
                } else {
                    
                    showAlertDialog(dtype: "Alert", msg: "Account Not Successfully Created", style: "alert", controller: "")
                  
                  }
            case 1:
                showAlertDialog(dtype : "Error",  msg : "Username already exists!", style : "alert", controller: "")
            default:
                showAlertDialog(dtype : "Error",  msg : "Database Connection Error!", style : "alert", controller: "")
            
            
        }
        
    }
    
    func showAlertDialog(dtype: String, msg: String, style: String, controller: String) {
        
        var dialogMessage = UIAlertController()
        var ok = UIAlertAction()
        
        switch style.lowercased() {
            case "alert":
                dialogMessage = UIAlertController(title: dtype, message: msg, preferredStyle: .alert)
                //ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
                ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    if controller != "" {
                        //self.goToNextController(segueId: controller)
                        let rvc = self.storyboard?.instantiateViewController(withIdentifier: storyBoards.home) as! HomeViewController
                        self.present(rvc, animated: true)
                    }
                })
                dialogMessage.addAction(ok)
            default:
                print("No alert available")
        }
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func goToNextController(segueId: String) {
        
        performSegue(withIdentifier: segueId, sender: self)
        
    }
    
    @IBAction func backToWelcomePressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
