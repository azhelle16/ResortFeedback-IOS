//
//  ViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/4/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        let wvc = storyboard?.instantiateViewController(identifier: storyBoards.register) as! RegisterViewController
        present(wvc, animated: true)
 
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let wvc = storyboard?.instantiateViewController(identifier: storyBoards.login) as! LoginViewController
        present(wvc, animated: true)
        
    }

}


