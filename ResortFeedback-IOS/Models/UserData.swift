//
//  UserData.swift
//  ResortFeedback-IOS
//
//  Created by Maricel Sumulong on 3/6/22.
//

import Foundation
import UIKit

struct UserData {
    
    static var userInfo : String = ""
    static var tallyScore : [String : Int] = [:]
    
    func centerCollectionView(collectionView: UICollectionView) {
        
        var screenSize: CGRect!
        var screenWidth: CGFloat!
        //let screenHeight: CGFloat!
        
        screenSize = UIScreen.main.bounds
        screenWidth = screenSize.width
        //screenHeight = screenSize.height
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
    }
    
}
