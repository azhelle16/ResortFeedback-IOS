//
//  EditFoodSurveyViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/9/22.
//

import UIKit

class EditFoodSurveyViewController: UIViewController {

    @IBOutlet weak var editFoodTableView: UITableView!
    
    var tallyScore : [String : Int] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editFoodTableView.delegate = self
        editFoodTableView.dataSource = self
        editFoodTableView.register(UINib(nibName: r.editfoodNibName, bundle: nil), forCellReuseIdentifier: r.editFoodCellIdentifier)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let con = convertStringToDictionary(text: UserData.userScore)
        rebuildTable(jSon : con)
    }
    
    @IBAction func submitEditFoodResponse(_ sender: UIButton) {
        
        let scoreArray = [Int](repeating: 0, count: questions.foodQuestions.count)
        var tallyArray = ["Food":scoreArray]
        var finalArr : [[String : [Int]]] = []
        
        for key in UserData.userScoreTracker.keys {
            tallyArray["Food"]![Int(key)!] = UserData.userScoreTracker[key]!
            
        }
        
        finalArr.append(tallyArray)
        
        //print(finalArr.description)
        
        let encoder = JSONEncoder()
        var jsonStr : String = ""
        if let jsonData = try? encoder.encode(finalArr) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                jsonStr = jsonString
            }
        }
        
        let isSuccess = DBManager.inst.addUserFoodTally(u: UserData.userInfo, t: jsonStr)

        if isSuccess == true {

            UserData.userScore = jsonStr
            showAlertDialog(dtype: "Alert", msg: "Response Successfully Saved! Redirecting You Back To Home Page", style: "alert", controller : r.backToSurveyHome)

            //print("Under Construction!")

        } else {

            showAlertDialog(dtype: "Alert", msg: "Response Not Successfully Saved.", style: "alert", controller: "")

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
                        let efvc = self.storyboard?.instantiateViewController(withIdentifier: storyBoards.edit_survey) as! EditRatingsViewController
                        self.present(efvc, animated: true, completion: nil)
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
        
        UserData.userScoreTracker = [:]
        let efvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.edit_survey) as! EditRatingsViewController
        present(efvc, animated: true, completion: nil)

    }
    
    func convertStringToDictionary(text: String) -> [Int] {
        
        //print("TEXT: \(text)")
        //let t = "[{\"Food\" : [1,2,3,4,5,5,4,3,2,1]}]"
       
        let data = text.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
            {
                //print(jsonArray)// use the json here
                return jsonArray[0]["Food"] as! [Int]

            } else {
                print("bad json")
            }
        } catch let error as NSError {
            print(error)
        }
        
        return []
       //return nil
   }
    
    

}

extension EditFoodSurveyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        
            case 0:
                //print("ROWS: ",r.questions.count * 2)
                //return r.questions.count + 1
            return min(questions.foodQuestions.count, 15)
            default:
                return 0
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
            case 0:
            
                let cell = tableView.dequeueReusableCell(withIdentifier: r.editFoodCellIdentifier, for: indexPath) as! EditFoodTableViewCell
                
                cell.question.text = questions.foodQuestions[indexPath.row]
                let qNum = indexPath.row
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
                
            default:
                let defCell = tableView.dequeueReusableCell(withIdentifier: r.editFoodCellIdentifier, for: indexPath)
                print("no default")
                return defCell
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
}

extension EditFoodSurveyViewController: UITableViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
        if UserData.userScoreTracker.count != 0 {
            for key in UserData.userScoreTracker.keys{
                let indexPath = IndexPath(row: Int(key)!, section: 0)
                let cell = editFoodTableView.cellForRow(at: indexPath) as? EditFoodTableViewCell
                let selected = UserData.userScoreTracker[key]

                switch selected {
                    case 1:
                        cell?.fRateImage1.alpha = 1
                    case 2:
                        cell?.fRateImage2.alpha = 1
                    case 3:
                        cell?.fRateImage3.alpha = 1
                    case 4:
                        cell?.fRateImage4.alpha = 1
                    default:
                        cell?.fRateImage5.alpha = 1
                }

            }

        }
        
    }
    
    func rebuildTable(jSon : [Int]) {
        
        for key in 0...jSon.count - 1 {
            let indexPath = IndexPath(row: key, section: 0)
            let cell = editFoodTableView.cellForRow(at: indexPath) as? EditFoodTableViewCell
            let selected = jSon[key]
            UserData.userScoreTracker[String(key)] = selected

            //print(indexPath)
            switch selected {
                
                case 1:
                    cell?.fRateImage1.alpha = 1
                case 2:
                    cell?.fRateImage2.alpha = 1
                case 3:
                    cell?.fRateImage3.alpha = 1
                case 4:
                    cell?.fRateImage4.alpha = 1
                default:
                    cell?.fRateImage5.alpha = 1
            
            }

        }
        
    }
    
}
