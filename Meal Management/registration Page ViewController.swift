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
    
    let compos01 = ["中華","フレンチ","イタリアン",""]
    let compos02 = [5,4,3,2,1]
    let compos03 = [5,4,3,2,1]
    let compos04 = [5,4,3,2,1]
    var picture_data: NSData? = nil
    var item01 = "" //String
    var item02 = 0 //String
    var item03 = 0 //String
    var item04 = 0 //String
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var place: UITextField!
    @IBOutlet weak var genres: UIPickerView!
    @IBOutlet weak var taste_evaluation: UIPickerView!
    @IBOutlet weak var atmosphere_evaluation: UIPickerView!
    @IBOutlet weak var cost_evaluation: UIPickerView!
    
    @IBOutlet weak var recommended_menu: UITextField!
    
    @IBAction func add_picture(_ sender: Any){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        // 写真を選ぶビュー
        let pickerView = UIImagePickerController()
        // 写真の選択元をカメラロールにする
        // 「.camera」にすればカメラを起動できる
        pickerView.sourceType = .photoLibrary
        // デリゲート
        pickerView.delegate = self
        // ビューに表示
        self.present(pickerView, animated: true)
        }
    }
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        picture_data = image.pngData()! as NSData
        // ビューに表示する
        //self.imageView.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
    
  // UIPickerView作成
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
    
    // 各コンポーネントの横幅の指定
    
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
        restaurant.picture_data = picture_data!
        
        access.dbRegistration(restaurant:restaurant)

        cflag = 1
   }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegate設定
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
