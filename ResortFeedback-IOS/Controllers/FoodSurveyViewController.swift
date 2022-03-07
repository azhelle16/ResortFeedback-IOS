//
//  FoodSurveyViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/6/22.
//

import UIKit

class FoodSurveyViewController: UIViewController {

    @IBOutlet weak var foodTableView: UITableView!
    
    var tallyScore : [String : Int] = [:]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        foodTableView.delegate = self
        foodTableView.dataSource = self
        foodTableView.register(UINib(nibName: r.foodNibName, bundle: nil), forCellReuseIdentifier: r.foodCellIdentifier)
        foodTableView.register(UINib(nibName: r.foodRateNibName, bundle: nil), forCellReuseIdentifier: r.foodRateCellIdentifier)
        
    }
    
    @IBAction func submitFoodResponse(_ sender: UIButton) {
        
//        print(UserData.tallyScore)
//        var tally : Int = 0
//        for (key, value) in UserData.tallyScore {
//            tally += value
//        }
//
//        print("FINAL TALLY: \(tally)")
        
        let isSuccess = DBManager.inst.addUserFoodTally(u: UserData.userInfo, t: UserData.tallyScore.description)
        
        if isSuccess == true {
            
            showAlertDialog(dtype: "Alert", msg: "Response Successfully Saved! Redirecting You Back To Survey Home Page", style: "alert", controller : r.backToSurveyHome)
            
            //print("Under Construction!")
            
        } else {
            
            showAlertDialog(dtype: "Alert", msg: "Response Not Successfully Created", style: "alert", controller: "")
          
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

extension FoodSurveyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        
            case 0:
                //print("ROWS: ",r.questions.count * 2)
                return r.questions.count+1
            default:
                return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
            case 0:
            
                if indexPath.row % 2 == 0 {
                        
                    let cell = tableView.dequeueReusableCell(withIdentifier: r.foodCellIdentifier, for: indexPath) as! FoodSurveyTableViewCell
                
                    cell.question.text = r.questions[indexPath.row]

                    return cell
                    
                } else {
                      
                    let cell = tableView.dequeueReusableCell(withIdentifier: r.foodRateCellIdentifier, for: indexPath) as! FoodRatingTableViewCell

                   var qNum : Int = 0
                    if indexPath.row == 1 {
                        qNum = indexPath.row
                    } else {
                        qNum = indexPath.row-1
                     }
                    cell.fRateImage1.accessibilityIdentifier = String(qNum)+"-1"
                    cell.fRateImage2.accessibilityIdentifier = String(qNum)+"-2"
                    cell.fRateImage3.accessibilityIdentifier = String(qNum)+"-3"
                    cell.fRateImage4.accessibilityIdentifier = String(qNum)+"-4"
                    cell.fRateImage5.accessibilityIdentifier = String(qNum)+"-5"
                    cell.fRateImage1.alpha = 0.3
                    cell.fRateImage2.alpha = 0.3
                    cell.fRateImage3.alpha = 0.3
                    cell.fRateImage4.alpha = 0.3
                    cell.fRateImage5.alpha = 0.3
                    
                    return cell
                        
                  }
                
            
            default:
                let defCell = tableView.dequeueReusableCell(withIdentifier: r.foodCellIdentifier, for: indexPath)
                print("no default")
                return defCell
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
}

extension FoodSurveyViewController: UITableViewDelegate {
    
}
