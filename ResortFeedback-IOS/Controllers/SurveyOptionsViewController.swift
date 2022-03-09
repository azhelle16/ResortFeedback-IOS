//
//  SurveyOptionsViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/6/22.
//

import UIKit

class SurveyOptionsViewController: UIViewController {

    @IBOutlet weak var surveyIntroTextView: UITextView!
    @IBOutlet weak var surveyCollectionView: UICollectionView!
    
    var surveyChoices : [String] = [
        "Rooms",
        "Amenities",
        "Food",
        "Overall Feedback"
    ]
    
    var surveyChoicesIcon : [String] = [
        "room",
        "amenities",
        "food",
        "feedback"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        surveyIntroTextView.text = "    Hi, \(UserData.userInfo)! Help us improve and serve better to customers like you. Simply select any of the options below and fill up all the questions provided. Any feedback are highly appreciated."
        surveyCollectionView.dataSource = self
        surveyCollectionView.delegate = self
        surveyCollectionView.register(UINib(nibName: r.surveyNibName, bundle: nil), forCellWithReuseIdentifier: r.surveyCellIdentifier)
        
        let fixCenter = UserData()
        fixCenter.centerCollectionView(collectionView: surveyCollectionView)
        
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

extension SurveyOptionsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return surveyChoices.count

    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: r.surveyCellIdentifier, for: indexPath) as! SurveyOptionsCollectionViewCell

        cell.surveyImageView.image = UIImage(named: surveyChoicesIcon[indexPath.row])
        cell.surveyLabel.text = surveyChoices[indexPath.row]

        return cell

    }



}

extension SurveyOptionsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
            case 2:
                //print("Time To Answer Survey")
                performSegue(withIdentifier: r.foodSegue, sender: self)
            case 3:
                performSegue(withIdentifier: r.feedbackSegue, sender: self)
            default:
                //print("Under Construction")
                performSegue(withIdentifier: r.constructionSegue2, sender: self)
        }
        
    }
}
