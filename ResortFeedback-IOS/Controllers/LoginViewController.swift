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
        
        let exists = DBManager.inst.checkUserAvailability(u: logUserTextField.text!)
        
        if exists == 0 {
            showAlertDialog(dtype : "Error",  msg : "Account doesn't exists. Please register first.", style : "alert", controller: "")
            return
        }
        
        let isCorrect = DBManager.inst.login(u: logUserTextField.text!, p: logPasswordTextField.text!)
        
        if isCorrect.count != 0 {
            
            UserData.userInfo = isCorrect[0].username!
            UserData.userScore = isCorrect[0].scores!
            UserData.userFeedback = isCorrect[0].feedback!
            
            let lvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.home) as! HomeViewController
            present(lvc, animated: true)
            //self.goToNextController(segueId: r.loginSegue)
            
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
    
    @IBAction func backButtonToWelcomePressed(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
