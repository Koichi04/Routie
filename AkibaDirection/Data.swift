//
//  Data.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/06/03.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit

class Data: NSObject {
    var title: String
    var selected: Bool
    var number: Int
    var lat: Double
    var lon: Double
    var adress: String
    var details: String
    var recommend: String
    var images: UIImage
    
    
    
    init(title: String, selected: Bool, number: Int, lat: Double, lon: Double,
         adress: String, details: String, recommend: String, images: UIImage) {
        self.title = title
        self.selected = selected
        self.number = number
        self.lat = lat
        self.lon = lon
        self.adress = adress
        self.details = details
        self.recommend = recommend
        self.images = images
        
    }

}
