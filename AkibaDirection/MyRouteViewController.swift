//
//  MyRouteViewController.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/06/11.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit
import RealmSwift

class MyRouteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var recordData = [MyRouteData3]()
    var data = MyRouteData3()
    
    @IBOutlet var myRouteTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRouteTableView.delegate = self
        myRouteTableView.dataSource = self
        
        self.navigationController!.navigationBar.barStyle = .blackTranslucent
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 0.9524763227, green: 0.5826503038, blue: 0.2409116328, alpha: 1)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.myRouteTableView.frame.width,
                                                  height: self.myRouteTableView.frame.height))
        let image = UIImage(named: "夜の秋葉原 messed up.jpg")
        
        imageView.alpha = 0.3
        imageView.image = image
        
        self.myRouteTableView.backgroundView = imageView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        read()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //print(recordData)
    }
    
    func read() {
        recordData = MyRouteData3.loadAll()
        // print(recordData[0].routeName)
        myRouteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeNameCell")!
        cell.textLabel?.text = recordData[indexPath.row].routeName
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        return cell
    }
    
    // Cellを編集可能にする
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //セルを削除する
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let realm = try! Realm()
            print(indexPath.row)
            print(recordData)
            print(recordData.count)
            let object = realm.object(ofType: MyRouteData3.self, forPrimaryKey: self.recordData[indexPath.row].id)
            
           
            try! realm.write {
                realm.delete(object!)
            }
            
            recordData.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    //　myRouteTableViewのCellが押された時に呼ばれる関数
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //　画面遷移
        data = recordData[indexPath.row]
        //print("ここだよ！！")
        print(recordData[indexPath.row])
        self.performSegue(withIdentifier: "toMyMap", sender: nil)
        // 選択されたcellの選択の解除(メモ一覧に戻った時に選択が解除されている必要があるから)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMyMap" {
            let myMapVC = segue.destination as! MyMapViewController
            myMapVC.receivedDatas2 = data
            //let selectedIndex = myRouteTableView.indexPathForSelectedRow!
            //myMapVC.selectedIndex = selectedIndex
            //myMapVC.selectedName = recordData[selectedIndex.row]
        }
    }
    
    

}
