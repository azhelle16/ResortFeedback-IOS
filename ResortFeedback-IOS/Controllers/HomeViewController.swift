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
    
    var userChoices : [String] = [
        "Answer Survey",
        "View Other's Ratings",
        "Change Username",
        "Change Password",
        "View My Rating",
        "Edit My Rating"
    ]
    
    var userChoicesIcon : [String] = [
        "survey",
        "response",
        "username",
        "password",
        "review",
        "edit"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        welcomeTextView.text = "Welcome, \(UserData.userInfo)!"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: r.homeNibName, bundle: nil), forCellWithReuseIdentifier: r.cellIdentifier)
//        tableView.dataSource = self
//        tableView.register(UINib(nibName: r.nibName, bundle: nil), forCellReuseIdentifier: r.cellIdentifier)
        
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

//extension HomeViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return userChoices.count
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: r.cellIdentifier, for: indexPath) as! HomeViewCell
//
//        cell.homeImageView.image = UIImage(named: userChoicesIcon[indexPath.row])
//        cell.homeSelections.text = userChoices[indexPath.row]
//
//        return cell
//    }
//
//
//
//
//}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return userChoices.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: r.cellIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        cell.homeImageView.image = UIImage(named: userChoicesIcon[indexPath.row])
        cell.homeLabel.text = userChoices[indexPath.row]
        
        
        return cell
        
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.item {
            case 0:
                //print("Time To Answer Survey")
                performSegue(withIdentifier: r.surveySegue, sender: self)
            default:
                //print("Under Construction")
                performSegue(withIdentifier: r.constructionSegue, sender: self)
        }
        
    }
    
}
