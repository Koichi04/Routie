//
//  PlaceViewController.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/06/24.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {
    
    
    var receivedData: Data!
    
    @IBOutlet var placeImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var adressLabel: UILabel!
    @IBOutlet var detailTextView: UITextView!
    @IBOutlet var recommendLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appearImage()
        appearName()
        appearAdress()
        appearDetails()
        appearRecommend()
        
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
        adressLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
    }
    
    
    
    
    func appearImage() {
        placeImageView.image = receivedData.images
        
    }
    
    func appearName() {
        nameLabel.text = receivedData.title
        
    }
    
    func appearAdress() {
        adressLabel.text = receivedData.adress
        
    }
    
    func appearDetails() {
        detailTextView.text = receivedData.details
    }
    
    func appearRecommend() {
        recommendLabel.text = receivedData.recommend
    }

}
