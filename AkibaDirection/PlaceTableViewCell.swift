//
//  PlaceTableViewCell.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/05/30.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit
import BEMCheckBox
import NaturalLanguage

class PlaceTableViewCell: UITableViewCell {
    
    
    @IBOutlet var akibaImageView: UIImageView!
    @IBOutlet var placeNameLabel : UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var checkBox: BEMCheckBox!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        placeNameLabel.numberOfLines = 0
        placeNameLabel.lineBreakMode = .byWordWrapping
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}
