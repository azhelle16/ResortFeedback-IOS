//
//  OverAllFeedbackViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/8/22.
//

import UIKit

class OverAllFeedbackViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var fbImage1: UIButton!
    @IBOutlet weak var fbImage2: UIButton!
    @IBOutlet weak var fbImage3: UIButton!
    @IBOutlet weak var fbImage4: UIButton!
    @IBOutlet weak var fbImage5: UIButton!
    
    @IBOutlet weak var buttonView: UIView!
    
    var fbScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.feedbackTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        buttonView.layer.cornerRadius = buttonView.frame.size.height / 5
        fbImage1.alpha = 0.3
        fbImage2.alpha = 0.3
        fbImage3.alpha = 0.3
        fbImage4.alpha = 0.3
        fbImage5.alpha = 0.3
        fbImage1.accessibilityIdentifier = "1"
        fbImage2.accessibilityIdentifier = "2"
        fbImage3.accessibilityIdentifier = "3"
        fbImage4.accessibilityIdentifier = "4"
        fbImage5.accessibilityIdentifier = "5"
        feedbackTextView.delegate = self
        
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitFeedback(_ sender: Any) {
        
        let toSubmit : [String : Any] = ["Feedback": feedbackTextView.text!, "Score" : fbScore]
        
        print(toSubmit.description)
        
        let isSuccess = DBManager.inst.addUserOverallFeedback(u: UserData.userInfo, f: toSubmit.description )

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
                        //self.goToNextController(segueId: controller)
                        let fbvc = self.storyboard?.instantiateViewController(withIdentifier: storyBoards.survey) as! SurveyOptionsViewController
                        self.present(fbvc, animated: true, completion: nil)
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
    
    @IBAction func backToSurveyPressed(_ sender: UIButton) {
        
        let fbvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.home) as! HomeViewController
        present(fbvc, animated: true, completion: nil)
        
    }
    
    @IBAction func feedbackButtonPressed(_ sender: UIButton) {
        
        fbImage1.alpha = 0.3
        fbImage2.alpha = 0.3
        fbImage3.alpha = 0.3
        fbImage4.alpha = 0.3
        fbImage5.alpha = 0.3
        sender.alpha = 1
        
        fbScore = Int(sender.accessibilityIdentifier!)!
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        let charUsed = textView.text!.count
        feedbackLabel.text = String(charUsed)+"/500"
        
        if charUsed > 500 {
            //print(feedbackTextView.text!.prefix(500))
            feedbackTextView.text = String(feedbackTextView.text!.prefix(500))
            feedbackLabel.text = "500/500"
        }
        
    }

}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        //Code lifted from www.swiftdevcenter.com/uitextview-dismiss-keyboard-swift/
        
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
    
}

