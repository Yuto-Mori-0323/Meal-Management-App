//
//  registration Page ViewController.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/24.
//  Copyright © 2018年 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

class registration_Page_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    let compos01 = ["中華","フレンチ","イタリアン",""] //ジャンル
    let compos02 = [5,4,3,2,1] //味の評価
    let compos03 = [5,4,3,2,1] //雰囲気の評価
    let compos04 = [5,4,3,2,1] //コスパの評価
    var picture_data: NSData? = nil //画像
    var item01 = "中華" //初期値はUIPickerViewの一番上の表示
    var item02 = 5 //初期値はUIPickerViewの一番上の最初の表示
    var item03 = 5 //初期値はUIPickerViewの一番上の最初の表示
    var item04 = 5 //初期値はUIPickerViewの一番上の最初の表示
    
    @IBOutlet weak var name: UITextField! //店名
    @IBOutlet weak var place: UITextField! //場所
    @IBOutlet weak var genres: UIPickerView! //ジャンル
    @IBOutlet weak var taste_evaluation: UIPickerView! //味の評価
    @IBOutlet weak var atmosphere_evaluation: UIPickerView! //雰囲気の評価
    @IBOutlet weak var cost_evaluation: UIPickerView! //コスパの評価
    @IBOutlet weak var recommended_menu: UITextField! //オススメメニュー
    
    //カメラロールから写真の選択
    @IBAction func add_picture(_ sender: Any){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            // 写真を選ぶビュー
            let pickerView = UIImagePickerController()
            // 写真の選択元をカメラロールにする
            // 「.camera」にすればカメラを起動できる（メモ）
            pickerView.sourceType = .photoLibrary
            pickerView.delegate = self
            // ビューに表示
            self.present(pickerView, animated: true)
        }
    }
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        //UIImageをNSDataに変換(UIImageはRealmで保存できないため)
        picture_data = image.pngData()! as NSData
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
    
    // ここからUIPickerView作成
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        switch pickerView.tag {
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        switch pickerView.tag {
        case 1:
            return compos01.count
        case 2:
            return compos02.count
        case 3:
            return compos03.count
        case 4:
            return compos04.count
        default:
            return 0
        }
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return compos01[row]
        case 2:
            return String(compos02[row])
        case 3:
            return String(compos03[row])
        case 4:
            return String(compos04[row])
        default:
            return ""
        }
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            item01 = compos01[row]
        case 2:
            item02 = compos02[row]
        case 3:
            item03 = compos03[row]
        case 4:
            item04 = compos04[row]
        default:
            break
        }
    }
    // ここまでUIPickerView作成
    
    //登録開始
    @IBAction func Registration(_ sender: Any) {
        let access = dbAccess()
        access.dbRebuilding()
        
        let restaurant = Restaurant()
        restaurant.name = name.text!
        restaurant.place = place.text!
        restaurant.genres = item01
        restaurant.taste_evaluation = item02
        restaurant.atmosphere_evaluation = item03
        restaurant.cost_evaluation = item04
        restaurant.recommended_menu = recommended_menu.text!
        let total_evaluation = item02 + item03 + item04
        restaurant.total_evaluation = total_evaluation
        if let picture_data = picture_data {
            restaurant.picture_data = picture_data
        }else{
            //写真を選択していなかったらデフォルト写真を設定
            let picture_image = UIImage(named: "default")
            picture_data = picture_image?.pngData()! as! NSData
            restaurant.picture_data = picture_data
        }
        
        access.dbRegistration(restaurant:restaurant)

        //前の画面に戻ったときDBを再読み込みしTableViewを再表示させる
        cflag = 1
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genres.delegate = self
        genres.dataSource = self
        genres.tag = 1
    
        taste_evaluation.delegate = self
        taste_evaluation.dataSource = self
        taste_evaluation.tag = 2

        atmosphere_evaluation.delegate = self
        atmosphere_evaluation.dataSource = self
        atmosphere_evaluation.tag = 3
        
        cost_evaluation.delegate = self
        cost_evaluation.dataSource = self
        cost_evaluation.tag = 4
        
    }

}
