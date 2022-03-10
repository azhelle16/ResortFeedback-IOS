//
//  EditRatingsViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/9/22.
//

import UIKit

class EditRatingsViewController: UIViewController {

    @IBOutlet weak var editSurveyIntroTextView: UITextView!
    @IBOutlet weak var editSurveyCollectionView: UICollectionView!
    
    let surveyOptions = mainMenu().surveyChoices
    let surveyIcons = mainMenu().surveyChoicesIcon
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editSurveyIntroTextView.text = "    Hi, \(UserData.userInfo)! Change of heart? Feel free to do any modifications you see fit during your stay."
        editSurveyCollectionView.dataSource = self
        editSurveyCollectionView.delegate = self
        editSurveyCollectionView.register(UINib(nibName: r.surveyNibName, bundle: nil), forCellWithReuseIdentifier: r.editSurveyCellIdentifier)
        
        let fixCenter = UserData()
        fixCenter.centerCollectionView(collectionView: editSurveyCollectionView)
    }
    
    @IBAction func backToSurveyPressed(_ sender: UIButton) {
        
        let esvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.home) as! HomeViewController
        present(esvc, animated: true, completion: nil)
        
    }

}

extension EditRatingsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return surveyOptions.count

    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: r.editSurveyCellIdentifier, for: indexPath) as! SurveyOptionsCollectionViewCell

        cell.surveyImageView.image = UIImage(named: surveyIcons[indexPath.row])
        cell.surveyLabel.text = surveyOptions[indexPath.row]

        return cell

    }



}

extension EditRatingsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
            
            case 0:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 1:
                let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(svc, animated: true, completion: nil)
            case 2:
            let svc = storyboard?.instantiateViewController(withIdentifier: storyBoards.edit_food_survey) as! EditFoodSurveyViewController
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
