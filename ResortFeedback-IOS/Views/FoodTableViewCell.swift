//
//  FoodTableViewCell.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/8/22.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var fRateImage1: UIButton!
    @IBOutlet weak var fRateImage2: UIButton!
    @IBOutlet weak var fRateImage3: UIButton!
    @IBOutlet weak var fRateImage4: UIButton!
    @IBOutlet weak var fRateImage5: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonsClicked(_ sender: UIButton) {
        
        fRateImage1.alpha = 0.3
        fRateImage2.alpha = 0.3
        fRateImage3.alpha = 0.3
        fRateImage4.alpha = 0.3
        fRateImage5.alpha = 0.3
        sender.alpha = 1
        
        let selInfo = sender.accessibilityIdentifier?.split(separator: "-")
        let key = selInfo![0]
        let score = selInfo![1]
        UserData.tallyScore[String(key)] = Int(score)!
//        print(UserData.tallyScore)
//        for (key, value) in UserData.tallyScore {
//            print("\(key) : \(value)")
//        }
        
    }
    
    
    
}
