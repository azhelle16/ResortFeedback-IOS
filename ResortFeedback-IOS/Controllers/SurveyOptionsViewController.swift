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
    
    let surveyOptions = mainMenu().surveyChoices
    let surveyIcons = mainMenu().surveyChoicesIcon
    
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
    
    @IBAction func backToHomePressed(_ sender: UIButton) {
        
        let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.home) as! HomeViewController
        present(svc, animated: true, completion: nil)
        
    }
    

}

extension SurveyOptionsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return surveyOptions.count

    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: r.surveyCellIdentifier, for: indexPath) as! SurveyOptionsCollectionViewCell

        cell.surveyImageView.image = UIImage(named: surveyIcons[indexPath.row])
        cell.surveyLabel.text = surveyOptions[indexPath.row]

        return cell

    }



}

extension SurveyOptionsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
            
            case 0:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 1:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 2:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.food_survey) as! FoodSurveyViewController
                present(svc, animated: true, completion: nil)
            case 3:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 4:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 5:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 6:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 7:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.feedback) as! OverAllFeedbackViewController
                present(svc, animated: true, completion: nil)
            default:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            
        }
        
    }
}
