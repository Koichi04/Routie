//
//  ViewController.swift
//  AkibaDirection
//
//  Created by Koichi Muranaka on 2020/05/27.
//  Copyright © 2020 Koichi Muranaka. All rights reserved.
//

import UIKit
import BEMCheckBox

class ViewController: UIViewController,
                      UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate {
    

    
    @IBOutlet var placeTableView: UITableView!
    
    var canScrollToTop: Bool = false
    

    // カテゴリの配列
    let categoryArray = ["定番", "エンタメ・ホビー", "メイドカフェ", "ゲームセンター", "ブックス", "食事処"]
    
    var d: Int = 0
    
    
    // Data型の配列を用意する
    var datas = [Data]()
    // 値渡しのための配列を用意する
    var selectedDatas = [Data]()
    
    var number: Int = 0
    
    var chechNumber: Int = 0
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeTableView.delegate = self
        
        placeTableView.dataSource = self
        
        
        self.navigationController!.navigationBar.barStyle = .blackTranslucent
        self.navigationController!.navigationBar.barTintColor = #colorLiteral(red: 0.9524763227, green: 0.5826503038, blue: 0.2409116328, alpha: 1)
        self.navigationController!.navigationBar.tintColor = .white
        self.navigationController!.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        
        //　カスタムセルの登録
        let nib = UINib(nibName: "PlaceTableViewCell", bundle: Bundle.main)
        placeTableView.register(nib, forCellReuseIdentifier: "PlaceCell")
        
        placeTableView.rowHeight = 105
        
        placeTableView.backgroundColor = UIColor(red: 1.000, green: 0.576, blue: 0.1490, alpha: 0.1)
        
        // cellの表示内容を決める
        
        
        createData()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        canScrollToTop = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.tabBarController?.delegate = self
        
        canScrollToTop = true
    }
    
    
    
    func createData() {
        // インスタンスを生成する　54個！！
        // 返り値はInitializerと呼ばれる
        let data1 = Data(title: "JR秋葉原駅", selected: false, number: 0, lat: 35.698531, lon: 139.773074, adress: "東京都千代田区外神田１丁目", details: "概要：秋葉原観光は、いつもここから始まる。（１番目の場所に選択することを推奨します）", recommend: "初心者おすすめ度：☆☆☆☆☆", images: UIImage(named: "JR秋葉原駅.jpg")!)
        
        let data2 = Data(title: "秋葉原ラジオ会館", selected: false, number: 0, lat: 35.697915, lon: 139.771957, adress: "〒101-0021 東京都千代田区外神田１丁目１５−１６", details: "概要：通称”ラジカン”。秋葉原に来たらまずここ！！と言われるほどの名所。アニメショップからおしゃれなカフェまで、様々な種類のお店が集まっている。", recommend: "初心者おすすめ度：☆☆☆☆☆", images: UIImage(named: "秋葉原ラジオ会館.jpg")!)
        
        let data3 = Data(title: "神田明神", selected: false, number: 0, lat: 35.702024, lon: 139.767855, adress: "〒101-0021 東京都千代田区外神田２丁目１６−２", details: "概要：８世紀に創建された由緒ある神社。ラブライブ！シリーズやシュタインズ・ゲートといった作品の舞台となり、アニメファンから聖地として崇められている。", recommend: "初心者おすすめ度：☆☆☆", images: UIImage(named: "神田明神.jpg")!)
        
        let data4 = Data(title: "秋葉原UDX", selected: false, number: 0,
                         lat: 35.700551, lon: 139.772508, adress: "〒101-0021 東京都千代田区外神田４丁目１４−１", details: "概要：秋葉原駅電気街口を出ると一番初めに見える高層ビル。デッキから美しい夜景を見ることができる。", recommend: "初心者おすすめ度：☆☆☆", images: UIImage(named: "秋葉原UDX.jpg")!)
        
        let data5 = Data(title: "マーチエキュート神田万世橋", selected:      false, number: 0, lat: 35.697433, lon: 139.769758, adress: "〒101-0041 東京都千代田区神田須田町１丁目２５−４", details: "概要：かつて中央線の駅として存在した「万世橋駅」の遺跡を利用したスポット。おしゃれなショップ・レストランが多く集まっており、一休憩するには最高の場所。赤レンガの旧駅舎と神田川を美しく照らす夜のライトアップは必見。", recommend: "初心者おすすめ度：☆☆☆☆", images: UIImage(named: "マーチエキュート.jpg")!)
        
        let data6 = Data(title: "アニメイト秋葉原本館", selected: false, number: 0,
                         lat: 35.700486, lon: 139.771785, adress: "〒101-0021 東京都千代田区外神田４丁目３−２", details: "", recommend: "", images: UIImage(named: "アニメイト秋葉原本館.jpg")!)
        
        let data7 = Data(title: "駿河屋秋葉原店アニメ・ホビー館", selected: false, number: 0, lat: 35.701546, lon: 139.771820, adress: "〒101-0021 東京都千代田区外神田１丁目８−８", details: "", recommend: "", images: UIImage(named: "駿河屋アニメ・ホビー館.jp2")!)

        let data8 = Data(title: "コトブキヤ 秋葉原館", selected: false, number: 0, lat: 35.699206, lon: 139.770435, adress: "〒101-0021 東京都千代田区外神田１丁目８−８", details: "", recommend: "", images: UIImage(named: "コトブキヤ.jpg")!)

        let data9 = Data(title: "ｱｲﾄﾞﾙﾏｽﾀｰｵﾌｨｼｬﾙｼｮｯﾌﾟｱﾄﾚ秋葉原店", selected: false, number: 0, lat: 35.698353, lon: 139.772304, adress: "〒101-0021 東京都千代田区外神田１丁目１７−１７ １０ アトレ秋葉原12階", details: "", recommend: "", images: UIImage(named: "アイドルマスターオフィシャル.jpg")!)

        let data10 = Data(title: "ハロー！プロジェクト オフィシャルショップ 東京秋葉原店", selected: false, number: 0, lat: 35.703180, lon: 139.771492, adress: "〒101-0021 東京都千代田区外神田６丁目１４−２ サカイ末広ビル6階", details: "", recommend: "", images: UIImage(named: "ハロー！プロジェクト オフィシャルショップ.jpg")!)

        let data11 = Data(title: "めいどりーみん秋葉原中央通り店", selected: false, number: 0, lat: 35.698339, lon: 139.771505, adress: "〒101-0021 東京都千代田区外神田１丁目１４−１ 宝田中央通りビル 2F", details: "", recommend: "", images: UIImage(named: "めいどりーみん秋葉原中央通り店.jpg")!)

        let data12 = Data(title: "アキバ絶対領域A.D.2045", selected: false, number: 0, lat: 35.700051, lon: 139.771983, adress: "〒101-0021 東京都千代田区外神田４丁目２−７ TIT秋葉原2F", details: "", recommend: "", images: UIImage(named: "アキバ絶対領域a.d.2045.jpg")!)

        let data13 = Data(title: "カフェ メイリッシュ", selected: false, number: 0, lat: 35.702314, lon: 139.769612, adress: "〒101-0021 東京都千代田区外神田３丁目６−２", details: "", recommend: "", images: UIImage(named: "カフェ メイリッシュ.jpg")!)

        let data14 = Data(title: "キュアメイドカフェ", selected: false, number: 0, lat: 35.701848, lon: 139.771227, adress: "〒101-0021 東京都千代田区外神田３丁目１５−５ ジーストア・アキバ6F", details: "", recommend: "", images: UIImage(named: "キュアメイドカフェ.jpg")!)

        let data15 = Data(title: "私設図書館 シャッツキステ", selected: false, number: 0, lat: 35.703241, lon: 139.770069, adress: "〒101-0021 東京都千代田区外神田６丁目５−１１", details: "", recommend: "", images: UIImage(named: "私設図書館 シャッツキステ.jpg")!)

        let data16 = Data(title: "セガ 秋葉原２号館", selected: false, number: 0, lat: 35.697759, lon: 139.771463, adress: "〒101-0021 東京都千代田区外神田１丁目１５−１", details: "", recommend: "", images: UIImage(named: "セガ 秋葉原２号館.jpg")!)

        let data17 = Data(title: "セガ 秋葉原４号館", selected: false, number: 0, lat: 35.698048, lon: 139.772423, adress: "〒101-0021 東京都千代田区外神田１丁目１５−９", details: "", recommend: "", images: UIImage(named: "セガ 秋葉原4号館.jpg")!)

        let data18 = Data(title: "スーパーポテト 秋葉原店", selected: false, number: 0, lat: 35.699378, lon: 139.770727, adress: "〒101-0021 東京都千代田区外神田１丁目１１−２", details: "", recommend: "", images: UIImage(named: "スーパーポテト 秋葉原店.jpg")!)

        let data19 = Data(title: "東京レジャーランド 秋葉原店", selected: false, number: 0, lat: 35.698821, lon: 139.770153, adress: "〒101-0021 東京都千代田区外神田１丁目９−５", details: "", recommend: "", images: UIImage(named: "東京レジャーランド 秋葉原店.jpg")!)

        let data20 = Data(title: "秋葉原Hey", selected: false, number: 0, lat: 35.699053, lon: 139.770836, adress: "〒101-0021 東京都千代田区外神田１丁目１０−５ 廣瀬本社ビル", details: "", recommend: "", images: UIImage(named: "秋葉原Hey.jpg")!)

        let data21 = Data(title: "AKIHABARAゲーマーズ本店", selected: false, number: 0, lat: 35.698324, lon: 139.771694, adress: "〒101-0021 東京都千代田区外神田１丁目１４−７ 宝田ビル", details: "", recommend: "", images: UIImage(named: "AKIHABARAゲーマーズ本店.jpg")!)

        let data22 = Data(title:  "まんだらけコンプレックス", selected: false, number: 0, lat: 35.700407, lon: 139.770542, adress: "〒101-0021 東京都千代田区外神田３丁目１１−１２", details: "", recommend: "", images: UIImage(named: "まんだらけ.jpg")!)

        let data23 = Data(title: "コミックとらのあな 秋葉原店", selected: false, number: 0, lat: 35.700412, lon: 139.771838, adress: "〒101-0021 東京都千代田区外神田４丁目３−１", details: "", recommend: "", images: UIImage(named: "コミックとらのあな 秋葉原店.jpg")!)

        let data24 = Data(title: "メロンブックス秋葉原1号店", selected: false, number: 0, lat: 35.698983, lon: 139.771070, adress: "〒101-0021 東京都千代田区外神田１丁目１０−５ 広瀬本社ビル B1", details: "", recommend: "", images: UIImage(named: "メロンブックス秋葉原1号店.jpg")!)

        let data25 = Data(title: "書泉ブックタワー", selected: false, number: 0, lat: 35.697317, lon: 139.775143, adress: "〒101-0025 東京都千代田区神田佐久間町１丁目１１−１", details: "", recommend: "", images: UIImage(named: "書泉ブックタワー.jpg")!)

        let data26 = Data(title: "モーゼスさんのケバブ AKIBA STYLE", selected: false, number: 0, lat: 35.701697, lon: 139.770230, adress: "〒101-0021 東京都千代田区外神田３丁目５−１３", details: "", recommend: "", images: UIImage(named: "モーゼスさんのケバブ AKIBA STYLE.jpg")!)

        let data27 = Data(title: "秋葉原最北端の肉酒場 ミナトグリル", selected: false, number: 0, lat: 35.704973, lon:  139.772800, adress: "〒101-0021 東京都千代田区外神田５丁目４−５", details: "", recommend: "", images: UIImage(named: "秋葉原最北端の肉酒場 ミナトグリル1.jpg")!)

        let data28 = Data(title: "Pasta Bar MAKITA", selected: false, number: 0, lat: 35.701747, lon: 139.769111, adress: "〒101-0021 東京都千代田区外神田２丁目１０−６", details: "", recommend: "", images: UIImage(named: "Pasta Bar MAKITA1.jpg")!)

        let data29 = Data(title: "秋葉原つけ麺 油そば 楽", selected: false, number: 0, lat: 35.702827, lon: 139.770668, adress: "〒101-0021 東京都千代田区外神田３丁目８−７ 神栄ビル1F", details: "", recommend: "", images: UIImage(named: "秋葉原つけ麺 油そば 楽.jpg")!)

        let data30 = Data(title: "とんこつラーメン 博多風龍 秋葉原総本店", selected: false, number: 0, lat: 35.701772, lon: 139.771342, adress: "〒101-0021 東京都千代田区外神田３丁目１５−６", details: "", recommend: "", images: UIImage(named: "とんこつラーメン 博多風龍 秋葉原総本店.jpg")!)
        
        
        // これらをdatasに格納 -> TableViewに表示したい
        datas = [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20,data21, data22, data23, data24, data25, data26, data27, data28, data29, data30]
        
        // PlaceTableviewDatasourceをもう一度読み込み
        placeTableView.reloadData()
    }
    
    
    // 画面遷移のための関数
    @IBAction func completionButton() {
            
        // 受渡し用の配列を一度初期化
        selectedDatas = [Data]()
        
        // datasの中でselectedがtrueのものすなわち選ばれたものだけをselectedDataに格納
        for i in datas {
            if i.selected == true {
                selectedDatas.append(i)
            } else {
                //選択されてない
            }
        }
        
        // selectedDataは順番がバラバラなので、sortedを使って選ばれた順番にかえる
        // 参考記事: https://program-life.com/692
        selectedDatas = selectedDatas.sorted(by: { (a, b) -> Bool in
            return a.number < b.number
        })
        
        // ここにif文とアラート書く
        if selectedDatas.count == 0 {
            let alert:UIAlertController = UIAlertController(title: "Caution", message: "何も選択されていません", preferredStyle: UIAlertController.Style.alert)
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action:UIAlertAction!) in}
            self.present(alert,animated: true, completion: nil)
            alert.addAction(okAction)
        
        } else if selectedDatas.count > 5 {
            let alert:UIAlertController = UIAlertController(title: "Caution", message: "5個まで選択可能です", preferredStyle: UIAlertController.Style.alert)
            let okAction:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (action:UIAlertAction!) in}
            self.present(alert,animated: true, completion: nil)
            alert.addAction(okAction)
            
        } else {
            
            //画面遷移のコード
            performSegue(withIdentifier: "toMap", sender: nil)
            
        }
    }
    
    @IBAction func cancelButton() {
        // CheckBoxの選択された状態を解除、値渡しの配列を空にする
        // ボタンを押したとき、datasのselectedがfalseになる
        number = datas.count
        
        for i in 0...number-1 {
            datas[i].selected = false
            datas[i].number = 0
        }
        
        // tableviewを再読み込み
        number = 0
        placeTableView.reloadData()
        
        //selectedDatas.removeAll()
    }
    
    
    //　値渡しのためのコード　重要！！！
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap" {
            let mapVC = segue.destination as! MapViewController
            mapVC.receivedDatas = selectedDatas
        }
        
        if segue.identifier == "toPlaceVC" {
            let placeVC = segue.destination as! PlaceViewController
            placeVC.receivedData = datas[chechNumber]
        }
        
    }
    
    
    
    
    // セルのSection・数・内容を決めるコード
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categoryArray[section]
    }

    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    
    //　セルの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        //idをつけたCellの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") as!
            PlaceTableViewCell
            //print(indexPath)
        
        
        
        
        if indexPath.section == 0 {
            cell.placeNameLabel.text = datas[indexPath.row].title
        } else if indexPath.section == 1 {
            cell.placeNameLabel.text = datas[indexPath.row+5].title
        } else if indexPath.section == 2 {
            cell.placeNameLabel.text = datas[indexPath.row+10].title
        } else if indexPath.section == 3 {
            cell.placeNameLabel.text = datas[indexPath.row+15].title
        } else if indexPath.section == 4 {
            cell.placeNameLabel.text = datas[indexPath.row+20].title
        } else if indexPath.section == 5 {
            cell.placeNameLabel.text = datas[indexPath.row+25].title
        }
        
        
        if indexPath.section == 0 {
            cell.akibaImageView.image = datas[indexPath.row].images
        } else if indexPath.section == 1 {
            cell.akibaImageView.image = datas[indexPath.row+5].images
        } else if indexPath.section == 2 {
            cell.akibaImageView.image = datas[indexPath.row+10].images
        } else if indexPath.section == 3 {
            cell.akibaImageView.image = datas[indexPath.row+15].images
        } else if indexPath.section == 4 {
            cell.akibaImageView.image = datas[indexPath.row+20].images
        } else if indexPath.section == 5 {
            cell.akibaImageView.image = datas[indexPath.row+25].images
        }
        
       
        
        if indexPath.section == 0 {
            cell.checkBox.tag = indexPath.row
        } else if indexPath.section == 1 {
            cell.checkBox.tag = indexPath.row + 5
        } else if indexPath.section == 2 {
            cell.checkBox.tag = indexPath.row + 10
        } else if indexPath.section == 3 {
            cell.checkBox.tag = indexPath.row + 15
        } else if indexPath.section == 4 {
            cell.checkBox.tag = indexPath.row + 20
        } else if indexPath.section == 5 {
            cell.checkBox.tag = indexPath.row + 25
        }
        
        
        // SectionとcheckBoxの組み合わせ
        cell.checkBox.delegate = self
        
        if indexPath.section == 0 && datas[indexPath.row].selected == true {
            cell.checkBox.on = true
        } else if indexPath.section == 0 && datas[indexPath.row].selected == false {
            cell.checkBox.on = false
        } else if indexPath.section == 1 && datas[indexPath.row + 5].selected == true {
            cell.checkBox.on = true
        } else if indexPath.section == 1 && datas[indexPath.row + 5].selected == false {
            cell.checkBox.on = false
        } else if indexPath.section == 2 && datas[indexPath.row + 10].selected == true {
            cell.checkBox.on = true
        } else if indexPath.section == 2 && datas[indexPath.row + 10].selected == false {
            cell.checkBox.on = false
        } else if indexPath.section == 3 && datas[indexPath.row + 15].selected == true {
            cell.checkBox.on = true
        } else if indexPath.section == 3 && datas[indexPath.row + 15].selected == false {
            cell.checkBox.on = false
        } else if indexPath.section == 4 && datas[indexPath.row + 20].selected == true {
            cell.checkBox.on = true
        } else if indexPath.section == 4 && datas[indexPath.row + 20].selected == false {
            cell.checkBox.on = false
        } else if indexPath.section == 5 && datas[indexPath.row + 25].selected == true {
            cell.checkBox.on = true
        } else if indexPath.section == 5 && datas[indexPath.row + 25].selected == false {
            cell.checkBox.on = false
        } else {
            
        }
        
        //初期状態含めcheckされている時はcheck表示、checkされていないときはfalseを表示
//        if datas[indexPath.row].selected == true {
//            cell.checkBox.on = true
//        } else {
//            cell.checkBox.on = false
//        }
        
        // cellに選ばれた順番の数を表示
        if indexPath.section == 0 && datas[indexPath.row].number != 0 {
            cell.countLabel.text = String(datas[indexPath.row].number)
        } else if indexPath.section == 1 && datas[indexPath.row + 5].number != 0 {
            cell.countLabel.text = String(datas[indexPath.row + 5].number)
        } else if indexPath.section == 2 && datas[indexPath.row + 10].number != 0 {
            cell.countLabel.text = String(datas[indexPath.row + 10].number)
        } else if indexPath.section == 3 && datas[indexPath.row + 15].number != 0 {
        cell.countLabel.text = String(datas[indexPath.row + 15].number)
        } else if indexPath.section == 4 && datas[indexPath.row + 20].number != 0 {
        cell.countLabel.text = String(datas[indexPath.row + 20].number)
        } else if indexPath.section == 5 && datas[indexPath.row + 25].number != 0 {
        cell.countLabel.text = String(datas[indexPath.row + 25].number)
        } else {
            cell.countLabel.text = ""
        }
        
//        if selectedDatas.count >= 5 {
//            //cell.checkBox.isUserInteractionEnabled = false
//        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 0 {
            chechNumber = indexPath.row
        } else if indexPath.section == 1 {
            chechNumber = indexPath.row + 5
        } else if indexPath.section == 2 {
            chechNumber = indexPath.row + 10
        } else if indexPath.section == 3 {
            chechNumber = indexPath.row + 15
        } else if indexPath.section == 4 {
            chechNumber = indexPath.row + 20
        } else if indexPath.section == 5 {
            chechNumber = indexPath.row + 25
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
            
        performSegue(withIdentifier: "toPlaceVC", sender: nil)

    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        
        let tabBarIndex = tabBarController.selectedIndex
        
        if tabBarIndex == 0 && canScrollToTop == true {
        
            self.placeTableView.setContentOffset(CGPoint.zero, animated: true)
        }
        
    }

}
    
    
extension ViewController: BEMCheckBoxDelegate {
        // checkBoxがタップされたら呼ばれるコード、おされたらselectedを切り替える
    func didTap(_ checkBox: BEMCheckBox) {
            
        if checkBox.on == true {
            // 押されたらnumberが１増えていく
            number += 1
            datas[checkBox.tag].selected = true
            datas[checkBox.tag].number = number
            
        } else {
            datas[checkBox.tag].selected = false
            // 消すnumberより大きい数字のものは1低くなる
            for i in datas {
                if i.number > datas[checkBox.tag].number {
                    // 選択解除でnumberが１減る
                    i.number -= 1
                } else {
                    
                }
            }
            
            // 選択解除されたらnumberは0
            datas[checkBox.tag].number = 0
            number -= 1
        }
            
        placeTableView.reloadData()
    }

    
}
   
    
    

