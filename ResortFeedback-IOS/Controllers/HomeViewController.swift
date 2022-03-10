//
//  HomeViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/5/22.
//

import UIKit

class HomeViewController: UIViewController {

//    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var welcomeTextView: UITextView!
    
    @IBOutlet weak var welcomeTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var homeOptions = mainMenu().userChoices
    var homeIcons = mainMenu().userChoicesIcon
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            if UserData.userScore == "" {
        
                homeOptions = [
                    "Answer Survey",
                    "View Other's Ratings",
                    "Settings",
                    "Clear Database"
                ]
        
                homeIcons = [
                    "survey",
                    "response",
                    "settings",
                    "cleardb"
                ]
            }
        welcomeTextView.text = "Welcome, \(UserData.userInfo)!"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: r.homeNibName, bundle: nil), forCellWithReuseIdentifier: r.cellIdentifier)
        
        // fixes UI layout for the home options
        
        let fixCenter = UserData()
        fixCenter.centerCollectionView(collectionView: collectionView)
        
    }
    
    func showAlertDialog(dtype: String, msg: String, style: String, controller: String) {
        
        var dialogMessage = UIAlertController()
        var ok = UIAlertAction()
        var yes = UIAlertAction()
        
        switch style.lowercased() {
            case "alert":
                dialogMessage = UIAlertController(title: dtype, message: msg, preferredStyle: .alert)
                //ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
                switch dtype.lowercased() {
                    case "confirm":
                        ok = UIAlertAction(title: "No", style: .default, handler: { (action) -> Void in
                        })
                        yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                            
                            switch controller {
                                case "1":
                                    self.deleteDatabase()
                                default:
                                    print("No controllers available")
                            }
                            
                            
                        })
                        dialogMessage.addAction(ok)
                        dialogMessage.addAction(yes)
                    case "error", "alert":
                        ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        })
                        dialogMessage.addAction(ok)
                    default:
                        print("No controls available")
                }
            default:
                print("No alert available")
        }
        
        self.present(dialogMessage, animated: true, completion: nil)
        
    }
    
    func deleteDatabase() {
        
        let isSuccess = DBManager.inst.deleteData()
        
        if isSuccess == true {
            showAlertDialog(dtype: "Alert", msg: "Database has been erased.", style: "alert", controller: "")
        } else {
            showAlertDialog(dtype: "Alert", msg: "Database is not erased.", style: "alert", controller: "")
          }
        
    }

    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        
        let hvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.welcome) as! WelcomeViewController
        present(hvc, animated: true, completion: nil)
        
    }
    
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeOptions.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: r.cellIdentifier, for: indexPath) as! HomeCollectionViewCell
            
        
        if UserData.userInfo != "admin" && indexPath.row == homeOptions.count - 1 {
            cell.homeLabel.text = ""
            cell.homeImageView.image = UIImage()
        } else if UserData.userScore == "" && [1,2,3].contains(indexPath.row) {
            cell.homeImageView.image = UIImage(named: homeIcons[indexPath.row])
            cell.homeLabel.text = homeOptions[indexPath.row]
            //cell.isHidden = true
            cell.isUserInteractionEnabled = true
        } else {
            cell.homeImageView.image = UIImage(named: homeIcons[indexPath.row])
            cell.homeLabel.text = homeOptions[indexPath.row]
          }
        
        return cell
        
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
            case 0:
                let hvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.survey) as! SurveyOptionsViewController
                present(hvc, animated: true, completion: nil)
            case 2:
                let hvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.edit_survey) as! EditRatingsViewController
                present(hvc, animated: true, completion: nil)
            case 6:
                showAlertDialog(dtype: "Confirm", msg: "This action can't be undone. Do you still want to proceed?", style: "alert", controller: "1")
            default:
                let hvc = storyboard?.instantiateViewController(withIdentifier: storyBoards.upcoming) as! UnderConstructionViewController
                present(hvc, animated: true, completion: nil)
        }
        
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    
}
