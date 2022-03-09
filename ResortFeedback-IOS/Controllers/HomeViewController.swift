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
    
    var currUser : String = ""
    
//    var screenSize: CGRect!
//    var screenWidth: CGFloat!
//    var screenHeight: CGFloat!
    
    var userChoices : [String] = [
        "Answer Survey",
        "View Other's Ratings",
        "Change Username",
        "Change Password",
        "View My Ratings",
        "Edit My Ratings",
        "Delete My Rating",
        "Clear Database"
    ]
    
    var userChoicesIcon : [String] = [
        "survey",
        "response",
        "username",
        "password",
        "review",
        "edit",
        "deleteRating",
        "cleardb"
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userChoices.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: r.cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        if UserData.userInfo != "admin" && indexPath.row == userChoices.count - 1 {
    
            cell.homeImageView.image = UIImage()
            cell.homeLabel.text = ""
            
        } else {
            
            cell.homeImageView.image = UIImage(named: userChoicesIcon[indexPath.row])
            cell.homeLabel.text = userChoices[indexPath.row]
        
          }
        
        return cell
        
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
            case 0:
                //print("Time To Answer Survey")
                performSegue(withIdentifier: r.surveySegue, sender: self)
            case 7:
                //print("Clears Database")
                //performSegue(withIdentifier: r.hometoDelete, sender: self)
                showAlertDialog(dtype: "Confirm", msg: "This action can't be undone. Do you still want to proceed?", style: "alert", controller: "1")
            
            default:
                //print("Under Construction")
                performSegue(withIdentifier: r.constructionSegue, sender: self)
        }
        
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    
    
    
    
    
}
