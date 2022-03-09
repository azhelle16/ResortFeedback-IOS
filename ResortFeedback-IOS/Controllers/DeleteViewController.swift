//
//  DeleteViewController.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/8/22.
//

import UIKit

class DeleteViewController: UIViewController {

    @IBOutlet weak var deleteTableView: UITableView!
    
    let deleteOptions = [
        "Delete Database",
        "Delete All Users",
        "Delete Specific User"
    ]
    
    let deleteIcons = [
        "deleteDB",
        "deleteUser"
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        deleteTableView.dataSource = self
        deleteTableView.delegate = self
        deleteTableView.register(UINib(nibName: r.deleteNibName, bundle: nil), forCellReuseIdentifier:  r.deleteTableViewCell)
        
    }
    


}

extension DeleteViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        switch section {
            
            case 0:
                return deleteOptions.count
            default:
                return 0
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: r.deleteTableViewCell, for: indexPath) as! DeleteTableViewCell
        
        cell.deleteLabel.text = deleteOptions[indexPath.row]
        cell.deleteImageView.image = UIImage(named: deleteIcons[indexPath.row])
        
        return cell
        
    }
    
    
    
}

extension DeleteViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    
//        switch indexPath.row {
//        case 0:
//            
//            
//            
//            
//        }
//        
//        
//    }
    
}
