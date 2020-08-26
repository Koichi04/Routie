//
//  MyMapViewController.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/06/15.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit
import PKHUD

class MyMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var receivedDatas2 = MyRouteData3()
    
    var titleArray = [String]()
    
    var latArray = [Double]()
    
    var lonArray = [Double]()
    
    var routeNames = String()
    
    var selectedId: Int?
    
    
    @IBOutlet var myMapTableView: UITableView!
    
    @IBOutlet var myMapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedId = receivedDatas2.id
        
        myMapTableView.delegate = self
        myMapTableView.dataSource = self
        self.myMapView.delegate = self
        
        // これ何してるん？
        getTitle(receivedArray: receivedDatas2)
        getLatitude(receivedArray2: receivedDatas2)
        getLongitude(receivedArray3: receivedDatas2)
        getRouteName(receivedArray4: receivedDatas2)
        myMapTableView.reloadData()
        makeMyMap()
        self.navigationItem.title = routeNames
        //read()
        //print(receivedDatas2)
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        // これ何してるん？
//        getTitle(receivedArray: receivedDatas2)
//        getLatitude(receivedArray2: receivedDatas2)
//        getLongitude(receivedArray3: receivedDatas2)
//        getRouteName(receivedArray4: receivedDatas2)
//        myMapTableView.reloadData()
//        makeMyMap()
//        self.navigationItem.title = routeNames
//        //read()
//        //print(receivedDatas2)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        print("KOKO!!")
        print(titleArray)
    }
    
//    func read() {
//        selectedName = MyRouteData3.loadAll()
//        // print(recordData[0].routeName)
//        myMapTableView.reloadData()
//    }
        
    
    func makeMyMap() {
        let coordinate = CLLocationCoordinate2DMake(latArray[0] as! CLLocationDegrees, lonArray[0] as! CLLocationDegrees)
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.myMapView.setRegion(region, animated: true)

        var routeCoordinates: [CLLocationCoordinate2D] = []

        for i in 0..<titleArray.count {
            let annotation = MKPointAnnotation()
            annotation.title = titleArray[i]
            annotation.coordinate = CLLocationCoordinate2DMake(latArray[i] as!  CLLocationDegrees, lonArray[i] as! CLLocationDegrees)
            let annotationCoordate = annotation.coordinate
            routeCoordinates.append(annotationCoordate)
            self.myMapView.addAnnotation(annotation)
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
                
                
                if error == nil {
                    
                    HUD.hide()
                    myRoute = response?.routes[0]
                    self.myMapView.addOverlay(myRoute.polyline,level: .aboveRoads)
                    
                } else if k == 0 && error != nil {
                    
                    HUD.hide()
                    let alert:UIAlertController = UIAlertController(title:"ネットワークエラー",
                    message: "マップディレクションを表示できません",
                    preferredStyle: UIAlertController.Style.alert)
                
                    let defaultAction:UIAlertAction = UIAlertAction(title: "戻る",
                    style: UIAlertAction.Style.default, handler:{
                        (action:UIAlertAction!) -> Void in
                        self.navigationController?.popViewController(animated: true)
                        }
                        )
                    
                    alert.addAction(defaultAction)
                    self.present(alert, animated: true, completion: nil)
                    
                    
                } else {
                    
                }
               
                
//                if k == 1 && error != nil {
//                    let alert:UIAlertController = UIAlertController(title:"No Internet Connection",
//                                        message: "マップディレクションを表示できません",
//                                        preferredStyle: UIAlertController.Style.alert)
//
//                                        let defaultAction:UIAlertAction = UIAlertAction(title: "戻る",
//                                                                                    style: UIAlertAction.Style.default,
//                                        handler:{
//                                        (action:UIAlertAction!) -> Void in
//                                            self.navigationController?.popViewController(animated: true)
//                                        }
//                                        )
//                                        alert.addAction(defaultAction)
//                                        self.present(alert, animated: true, completion: nil)
//                } else {
//                    myRoute = response?.routes[0]
//                    self.myMapView.addOverlay(myRoute.polyline,level: .aboveRoads)
//                }
                
                
//                    if error == nil {
//                       myRoute = response?.routes[0]
//                       self.myMapView.addOverlay(myRoute.polyline,level: .aboveRoads)
//
//
//                   } else {
//                    let alert:UIAlertController = UIAlertController(title:"No Internet Connection",
//                    message: "マップディレクションを表示できません",
//                    preferredStyle: UIAlertController.Style.alert)
//
//                    let defaultAction:UIAlertAction = UIAlertAction(title: "戻る",
//                                                                style: UIAlertAction.Style.default,
//                    handler:{
//                    (action:UIAlertAction!) -> Void in
//                        self.navigationController?.popViewController(animated: true)
//                    }
//                    )
//                    alert.addAction(defaultAction)
//                    self.present(alert, animated: true, completion: nil)
//                }
               })
           }
        }
   }
    
    @IBAction func deleteButton() {
        
        let alert: UIAlertController = UIAlertController(title: "削除", message: "保存したルートを削除しますか？", preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            
        }
        
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (UIAlertAction) in
            
            let realm = try! Realm()
            let object = realm.object(ofType: MyRouteData3.self, forPrimaryKey: self.selectedId)
            
            try! realm.write {
                   realm.delete(object!)
            }
               
            self.navigationController?.popViewController(animated: true)
            }
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var number = receivedDatas2.count
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMapCell")!
        print("!!!")
        print(titleArray)
        
        cell.textLabel?.text = titleArray[indexPath.row]
        
        let selectedIndex = indexPath.row
        
        tableView.tableFooterView = UIView(frame: .zero)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    

    func getTitle(receivedArray: MyRouteData3) {
        
        if receivedArray.title1 != "" {
            titleArray.append(receivedArray.title1)
        } else {
        
        }
        
        if receivedArray.title2 != "" {
            titleArray.append(receivedArray.title2)
        } else {
            
        }
        
        if receivedArray.title3 != "" {
            titleArray.append(receivedArray.title3)
        } else {
            
        }
        
        if receivedArray.title4 != "" {
            titleArray.append(receivedArray.title4)
        } else {
            
        }
        
        if receivedArray.title5 != "" {
            titleArray.append(receivedArray.title5)
        } else {
            
        }
        
    }
    
    func getLatitude(receivedArray2: MyRouteData3) {
        if receivedArray2.lat1 != nil {
            latArray.append(receivedArray2.lat1)
        } else {
            
        }
        
        if receivedArray2.lat2 != nil {
            latArray.append(receivedArray2.lat2)
        } else {
            
        }
        
        if receivedArray2.lat3 != nil {
            latArray.append(receivedArray2.lat3)
        } else {
            
        }
        
        if receivedArray2.lat4 != nil {
            latArray.append(receivedArray2.lat4)
        } else {
            
        }
        
        if receivedArray2.lat5 != nil {
            latArray.append(receivedArray2.lat5)
        } else {
            
        }
        
    }
    
    func getLongitude(receivedArray3: MyRouteData3) {
        if receivedArray3.lon1 != nil {
            lonArray.append(receivedArray3.lon1)
        } else {
            
        }
        
        if receivedArray3.lon2 != nil {
            lonArray.append(receivedArray3.lon2)
        } else {
            
        }
        
        if receivedArray3.lon3 != nil {
            lonArray.append(receivedArray3.lon3)
        } else {
            
        }
        
        if receivedArray3.lon4 != nil {
            lonArray.append(receivedArray3.lon4)
        } else {
            
        }
        
        if receivedArray3.lon5 != nil {
            lonArray.append(receivedArray3.lon5)
        } else {
            
        }
        
    }
    
    func getRouteName(receivedArray4: MyRouteData3) {
        routeNames.append(receivedArray4.routeName)
    }
        
    
}
    



extension MyMapViewController: MKMapViewDelegate {
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
        routeRenderer.strokeColor = UIColor(red:0.1, green:0.1, blue:1.00, alpha:1.0)
        routeRenderer.lineWidth = 8.0
        return routeRenderer
    }
    


}

