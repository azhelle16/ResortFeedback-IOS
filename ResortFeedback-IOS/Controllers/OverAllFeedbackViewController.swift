//
//  OverAllFeedbackViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/8/22.
//

import UIKit

class OverAllFeedbackViewController: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitFeedback(_ sender: Any) {
        
        let isSuccess = DBManager.inst.addUserOverallFeedback(u: UserData.userInfo, f: feedbackTextView.text!)

        if isSuccess == true {

            showAlertDialog(dtype: "Alert", msg: "Feedback Successfully Saved! Redirecting You Back To Survey Home Page", style: "alert", controller : r.backToFeedbackHome)

            //print("Under Construction!")

        } else {

            showAlertDialog(dtype: "Alert", msg: "Feedback Not Successfully Saved.", style: "alert", controller: "")

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
        
        performSegue(withIdentifier: segueId, sender: nil)
        
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
