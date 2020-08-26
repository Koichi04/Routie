//
//  MapViewController.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/06/04.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift
import PKHUD

class MapViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    var receivedDatas = [Data]()
    
        
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var mapView: MKMapView!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(receivedDatas)
            
        tableView.dataSource = self
        
        tableView.delegate = self
        
        self.mapView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         makeMap()
    }
    
        
    func makeMap() {
        let coordinate = CLLocationCoordinate2DMake(receivedDatas[0].lat as! CLLocationDegrees, receivedDatas[0].lon as! CLLocationDegrees)
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        var routeCoordinates: [CLLocationCoordinate2D] = []
        
        for i in 0..<receivedDatas.count {
            let annotation = MKPointAnnotation()
            annotation.title = receivedDatas[i].title
            annotation.coordinate = CLLocationCoordinate2DMake(receivedDatas[i].lat as! CLLocationDegrees, receivedDatas[i].lon as! CLLocationDegrees)
            let annotationCoordate = annotation.coordinate
            routeCoordinates.append(annotationCoordate)
            self.mapView.addAnnotation(annotation)
        }
        
        var myRoute: MKRoute!
        // https://qiita.com/magickworx/items/19e2f65d3b1216a14298
        let directionsRequest = MKDirections.Request()
        // MKMapItemとは？ https://hajihaji-lemon.com/smartphone/swift/mkmapitem/
        var placemarks = [MKMapItem]()
        //routeCoordinatesの配列からMKMapItemの配列に変換
        for item in routeCoordinates{
            let placemark = MKPlacemark(coordinate: item, addressDictionary: nil)
            placemarks.append(MKMapItem(placemark: placemark))
        }
        
        
        directionsRequest.transportType = .walking //移動手段は徒歩
        
        for (k, item) in placemarks.enumerated(){
            
            if k < (placemarks.count - 1){
                
                directionsRequest.source = item //スタート地点
                directionsRequest.destination = placemarks[k + 1] //目標地点
                
                let direction = MKDirections(request: directionsRequest)
                
                HUD.show(.labeledProgress(title: nil, subtitle: "ロード中..."))
                
                direction.calculate(completionHandler: {(response, error) in
                
                    
                
                print("ここ！！")
                print(error)
                print(response)
                    if error == nil {
                        
                        HUD.hide()
                        myRoute = response?.routes[0]
                        self.mapView.addOverlay(myRoute.polyline,level: .aboveRoads)
                        // mapViewに表示
        //polylineとは？->https://iostutorialjunction.com/2018/03/draw-route-on-apple-map-or-mapkit-tutorial-in-swift4.html
        //MKDirectionsについて->https://qiita.com/koogawa/items/d047a8056a0db5b05771
                    
                        
                    } else {
                        
                        HUD.hide()
                        
                        let alert:UIAlertController = UIAlertController(title:"ネットワークエラー",
                        message: "マップディレクションを表示できません",
                        preferredStyle: UIAlertController.Style.alert)
                        
                        let defaultAction:UIAlertAction = UIAlertAction(title: "戻る",
                                                                    style: UIAlertAction.Style.default,
                        handler:{
                        (action:UIAlertAction!) -> Void in
                            self.navigationController?.popViewController(animated: true)
                        }
                        )
                        alert.addAction(defaultAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
        
    }
    
    // PlaceCell2の数・内容
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            receivedDatas.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell2")
        cell?.textLabel?.text = receivedDatas[indexPath.row].title
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 選択されたcellの選択の解除(メモ一覧に戻った時に選択が解除されている必要があるから)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    var alertTextField: UITextField?
    
    
    @IBAction func save() {
        
        
        let alert:UIAlertController = UIAlertController(title:"保存",
            message: "ルート名を入力してください",
            preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            self.alertTextField = textField
        })

        // キャンセルの時のコード
        let cancelAction:UIAlertAction = UIAlertAction(title: "キャンセル",
                                                       style: UIAlertAction.Style.cancel,
            handler:{
            (action:UIAlertAction!) -> Void in
                print("キャンセル")
        })
        
        // 完了が押された時の挙動
        let defaultAction:UIAlertAction = UIAlertAction(title: "完了",
                                                        style: UIAlertAction.Style.default,
            handler:{
            (action:UIAlertAction!) -> Void in
                
                if self.alertTextField?.text?.count == 0 {
                    
                    let alert2:UIAlertController = UIAlertController(title: "注意", message: "ルート名が入力されていません", preferredStyle: UIAlertController.Style.alert)
                    let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action:UIAlertAction!) in
                        self.present(alert,animated: true, completion: nil)
                    }
                    alert2.addAction(okAction)
                    self.present(alert2, animated: true, completion: nil)
                    
                } else {
                    print("完了")
                    self.saveData()
                    
                }
                
        })
        
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)

        //textfiledの追加
    
        present(alert, animated: true, completion: nil)

        
        // データをRealmに持っていく
//        try! realm.write{
//            realm.add(myroute)
//        }
    }
    
    func saveData() {
        // Realmの宣言？
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        // 空のクラス作成
        let myroute = MyRouteData3.create()
        //　インスタンス化
        var number = receivedDatas.count
        
        // alertTextFieldに入力した内容をrouteNameに入れる
        myroute.routeName = self.alertTextField?.text! as! String
        
        for i in 0...number {
            
            
        }
        
        if number == 1 {
        
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
            
        }
        
        
        if number == 2 {
            
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
            
        }
        
        if number == 3 {
        
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        
        }
        
        if number == 4 {
        
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
            
        }
        
        if number == 5 {
        
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
        myroute.title5 = receivedDatas[4].title
        myroute.lat5 = receivedDatas[4].lat
        myroute.lon5 = receivedDatas[4].lon
            
        }
        
        if number == 6 {
        
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
        myroute.title5 = receivedDatas[4].title
        myroute.lat5 = receivedDatas[4].lat
        myroute.lon5 = receivedDatas[4].lon
        myroute.title6 = receivedDatas[5].title
        myroute.lat6 = receivedDatas[5].lat
        myroute.lon6 = receivedDatas[5].lon
            
        }

        if number == 7 {
            
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
        myroute.title5 = receivedDatas[4].title
        myroute.lat5 = receivedDatas[4].lat
        myroute.lon5 = receivedDatas[4].lon
        myroute.title6 = receivedDatas[5].title
        myroute.lat6 = receivedDatas[5].lat
        myroute.lon6 = receivedDatas[5].lon
        myroute.title7 = receivedDatas[6].title
        myroute.lat7 = receivedDatas[6].lat
        myroute.lon7 = receivedDatas[6].lon
        
        }

        if number == 8 {

        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
        myroute.title5 = receivedDatas[4].title
        myroute.lat5 = receivedDatas[4].lat
        myroute.lon5 = receivedDatas[4].lon
        myroute.title6 = receivedDatas[5].title
        myroute.lat6 = receivedDatas[5].lat
        myroute.lon6 = receivedDatas[5].lon
        myroute.title7 = receivedDatas[6].title
        myroute.lat7 = receivedDatas[6].lat
        myroute.lon7 = receivedDatas[6].lon
        myroute.title8 = receivedDatas[7].title
        myroute.lat8 = receivedDatas[7].lat
        myroute.lon8 = receivedDatas[7].lon
            
        }

        if number == 9 {
            
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
        myroute.title5 = receivedDatas[4].title
        myroute.lat5 = receivedDatas[4].lat
        myroute.lon5 = receivedDatas[4].lon
        myroute.title6 = receivedDatas[5].title
        myroute.lat6 = receivedDatas[5].lat
        myroute.lon6 = receivedDatas[5].lon
        myroute.title7 = receivedDatas[6].title
        myroute.lat7 = receivedDatas[6].lat
        myroute.lon7 = receivedDatas[6].lon
        myroute.title8 = receivedDatas[7].title
        myroute.lat8 = receivedDatas[7].lat
        myroute.lon8 = receivedDatas[7].lon
        myroute.title9 = receivedDatas[8].title
        myroute.lat9 = receivedDatas[8].lat
        myroute.lon9 = receivedDatas[8].lon
               
        }

        if number == 10 {
            
        myroute.title1 = receivedDatas[0].title
        myroute.lat1 = receivedDatas[0].lat
        myroute.lon1 = receivedDatas[0].lon
        myroute.title2 = receivedDatas[1].title
        myroute.lat2 = receivedDatas[1].lat
        myroute.lon2 = receivedDatas[1].lon
        myroute.title3 = receivedDatas[2].title
        myroute.lat3 = receivedDatas[2].lat
        myroute.lon3 = receivedDatas[2].lon
        myroute.title4 = receivedDatas[3].title
        myroute.lat4 = receivedDatas[3].lat
        myroute.lon4 = receivedDatas[3].lon
        myroute.title5 = receivedDatas[4].title
        myroute.lat5 = receivedDatas[4].lat
        myroute.lon5 = receivedDatas[4].lon
        myroute.title6 = receivedDatas[5].title
        myroute.lat6 = receivedDatas[5].lat
        myroute.lon6 = receivedDatas[5].lon
        myroute.title7 = receivedDatas[6].title
        myroute.lat7 = receivedDatas[6].lat
        myroute.lon7 = receivedDatas[6].lon
        myroute.title8 = receivedDatas[7].title
        myroute.lat8 = receivedDatas[7].lat
        myroute.lon8 = receivedDatas[7].lon
        myroute.title9 = receivedDatas[8].title
        myroute.lat9 = receivedDatas[8].lat
        myroute.lon9 = receivedDatas[8].lon
        myroute.title10 = receivedDatas[9].title
        myroute.lat10 = receivedDatas[9].lat
        myroute.lon10 = receivedDatas[9].lon
            
        }
        
        myroute.save()
        
        // 保存したとき、前の画面に値渡し
        let preNC = self.navigationController as! UINavigationController
        let preVC = preNC.viewControllers[preNC.viewControllers.count - 2] as! ViewController
        preVC.number = preVC.datas.count
            
            for i in 0...preVC.number-1 {
            preVC.datas[i].selected = false
            preVC.datas[i].number = 0
            }
        
            preVC.number = 0
            preVC.placeTableView.reloadData()
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
 
    
}



extension MapViewController: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation {
//            return nil
//        }
//        let reuseId = "pin"
//        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//        if pinView == nil {
//            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            pinView?.canShowCallout = true //吹き出しで情報を表示出来るように
//        }else{
//            pinView?.annotation = annotation
//        }
//        return pinView
//    }
    
    //ピンを繋げている線の幅や色を調整
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let route: MKPolyline = overlay as! MKPolyline
        
        let routeRenderer = MKPolylineRenderer(polyline: route)
        
//        print("ここだよ！！！")
//        print(routeRenderer)
        
        routeRenderer.strokeColor = UIColor(red:0.1, green:0.1, blue:1.00, alpha:1.0)
        
        routeRenderer.lineWidth = 8.0

        return routeRenderer
    }

}


