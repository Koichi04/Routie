//
//  MyRouteData3.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/06/11.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit
import RealmSwift

class MyRouteData3: Object {

    @objc dynamic var routeName: String = ""

    @objc dynamic var title1: String = ""
    @objc dynamic var lat1: Double = 0
    @objc dynamic var lon1: Double = 0
    
    @objc dynamic var title2: String = ""
    @objc dynamic var lat2: Double = 0
    @objc dynamic var lon2: Double = 0
    
    @objc dynamic var title3: String = ""
    @objc dynamic var lat3: Double = 0
    @objc dynamic var lon3: Double = 0
    
    @objc dynamic var title4: String = ""
    @objc dynamic var lat4: Double = 0
    @objc dynamic var lon4: Double = 0
    
    @objc dynamic var title5: String = ""
    @objc dynamic var lat5: Double = 0
    @objc dynamic var lon5: Double = 0
    
    @objc dynamic var title6: String = ""
    @objc dynamic var lat6: Double = 0
    @objc dynamic var lon6: Double = 0
    
    @objc dynamic var title7: String = ""
    @objc dynamic var lat7: Double = 0
    @objc dynamic var lon7: Double = 0
    
    @objc dynamic var title8: String = ""
    @objc dynamic var lat8: Double = 0
    @objc dynamic var lon8: Double = 0
    
    @objc dynamic var title9: String = ""
    @objc dynamic var lat9: Double = 0
    @objc dynamic var lon9: Double = 0
    
    @objc dynamic var title10: String = ""
    @objc dynamic var lat10: Double = 0
    @objc dynamic var lon10: Double = 0
    
    static let realm = try! Realm()
    
    
    @objc dynamic var id = 0
        
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func create() -> MyRouteData3 {
        let myRouteData = MyRouteData3()
        myRouteData.id = lastId()
        return myRouteData
    }
    
    
    static func lastId() -> Int {
        if let memo = realm.objects(MyRouteData3.self).last {
            return memo.id + 1
        } else {
            return 1
        }
    }
    
    
    func save() {
        try! MyRouteData3.realm.write {
            MyRouteData3.realm.add(self)
        }
    }
    
    // データを削除(Delete)するためのコード
    static func delete(wantToDelete: MyRouteData3) {
        let objects = realm.objects(MyRouteData3.self)
        try! realm.write {
            realm.delete(objects)
        }
    }
    
    static func loadAll() -> [MyRouteData3] {
        
    
    let myRouteDatas = realm.objects(MyRouteData3.self).sorted(byKeyPath: "id", ascending: false)
    
    var MyRouteDataArray: [MyRouteData3] = []
        
    
    for i in myRouteDatas {
        
    MyRouteDataArray.append(i)
        }
        return MyRouteDataArray
    }


    
}
