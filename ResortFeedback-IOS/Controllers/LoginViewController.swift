//
//  LoginViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/5/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logUserTextField: UITextField!
    @IBOutlet weak var logPasswordTextField: UITextField!
    
    var currUser : String = ""
    
    @IBAction func loginPressed(_ sender: Any) {
        
        //CHECK USER INPUT FIRST
        if logUserTextField.text! == "" || logPasswordTextField.text! == "" {
            
            showAlertDialog(dtype : "Error",  msg : "Please provide username and/or password.", style : "alert", controller: "")
            
        }
        
        //CHECK AVAILABILITY
        let isCorrect = DBManager.inst.login(u: logUserTextField.text!, p: logPasswordTextField.text!)
        
        if isCorrect.count != 0 {
            
            UserData.userInfo = isCorrect[0].username!
            self.goToNextController(segueId: r.loginSegue)
            
        } else {
            
            showAlertDialog(dtype : "Error",  msg : "Incorrect Username and/or Password.", style : "alert", controller: "")
        
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
                        self.goToNextController(segueId: controller)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //this function is for data passing
        
//        let hvc = segue.destination as! HomeViewController
//
//        hvc.currUser = currUser
        
    }
    
    
}
