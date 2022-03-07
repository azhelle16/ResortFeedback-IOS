//
//  FoodSurveyTableViewCell.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/6/22.
//

import UIKit

class FoodSurveyTableViewCell: UITableViewCell {

    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var fQButton1: UIButton!
    
    @IBOutlet weak var fQButton2: UIButton!
    @IBOutlet weak var fQButton3: UIButton!
    @IBOutlet weak var fQButton4: UIButton!
    @IBOutlet weak var fQButton5: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
