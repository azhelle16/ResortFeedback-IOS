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
        
        if isUnique == true {
            
            //ADD DATA
            let isSuccess = DBManager.inst.addData(u: regUserTextField.text!, p: regPasswordTextField.text!)
            
            if isSuccess == true {
                
                UserData.userInfo = regUserTextField.text!
                showAlertDialog(dtype: "Alert", msg: "Account Successfully Created", style: "alert", controller : r.registerSegue)
                
                //print("Under Construction!")
                
            } else {
                
                showAlertDialog(dtype: "Alert", msg: "Account Not Successfully Created", style: "alert", controller: "")
              
              }
            
        } else {
            
            showAlertDialog(dtype : "Error",  msg : "Username already exists!", style : "alert", controller: "")
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
