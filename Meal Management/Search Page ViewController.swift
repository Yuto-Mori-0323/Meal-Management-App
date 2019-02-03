//
//  Search Page ViewController.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/24.
//  Copyright © 2018年 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

var idList = [Int]() //検索結果画面(Search_Results_Page)に値を引き継ぎたいため、クラス外に変数を定義

class Search_Page_ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    //UIPickerViewに表示する内容
    //表示を追加したい場合はここに追加
    var compos01 = ["","中華","フレンチ","イタリアン"]
    var compos02 = ["","味","雰囲気","コスパ"]
    var compos03 = ["","5","4","3","2","1"]
    var compos04 = ["","15","14","13","12","11","10","9","8","7","6","5","4","3"]
    
    var item01 = "" //検索キーワード
    var item02 = "" //検索ジャンル
    var item03:Int? = 0 //個別(味 or 雰囲気 or コスパ)の評価値
    var item04:Int? = 0 //評価値の合計
    var queries:Int = 0 //クエリ
    
    @IBOutlet weak var keyword: UITextField! //検索キーワード
    @IBOutlet weak var genres: UIPickerView! //検索ジャンル
    @IBOutlet weak var evaluation_item: UIPickerView! //評価値の種類
    @IBOutlet weak var evaluation_point: UIPickerView! //個別(味 or 雰囲気 or コスパ)の評価値
    @IBOutlet weak var evaluation_totalpoint: UIPickerView! //評価値の合計
    
    //ここからUIPickerView作成
    //UIPickerViewの列の数
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
    
    //UIPickerViewの行数、リストの数
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
    
    //UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return compos01[row]
        case 2:
            return compos02[row]
        case 3:
            return compos03[row]
        case 4:
            return compos04[row]
        default:
            return ""
        }
    }
    
    //UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            item01 = compos01[row]
        case 2:
            item02 = compos02[row]
        case 3:
            item03 = Int(compos03[row])
        case 4:
            item04 = Int(compos04[row])
        default:
            break
        }
    }
    //ここまでUIPickerView作成
    
    //検索開始
    //各選択項目に対してor条件で検索される
    @IBAction func Search(_ sender: Any) {
        //クエリ文で使用できる変数名(Restaurantクラスのプロパティ名)に変更
        switch item02{
        case "味":
            item02 = "taste_evaluation"
        case "雰囲気":
            item02 = "atmosphere_evaluation"
        case "コスパ":
            item02 = "cost_evaluation"
        default:
            break
        }
       
        /*評価の点数が空欄　→ 検索条件から外す
        0にすることで全てのデータが検索される*/
        if item03 == nil {
           item03 = 0
        }
        
        let item03_unwrap = item03!
        
        /*評価の点数が空欄　→ 検索条件から外す
         0にすることで全てのデータが検索される*/
        if item04 == nil {
            item04 = 0
        }
        
        let item04_unwrap = item04!
        
        //オプショナルバリューのためアンラップ
        guard let keyword_text = keyword.text else{
            return
        }
        
        /*キーワード、ジャンル、評価項目それぞれが未記入の場合において場合分けし、
        各場合毎にクエリ文を生成*/
        if keyword_text != "",item01 != "",item02 != ""{
            queries = 1
        }else if keyword_text != "",item01 != "",item02 == ""{
            queries = 2
        }else if keyword_text != "",item01 == "",item02 != ""{
            queries = 3
        }else if keyword_text != "",item01 == "",item02 == ""{
            queries = 4
        }else if keyword_text == "",item01 != "",item02 != ""{
            queries = 5
        }else if keyword_text == "",item01 != "",item02 == ""{
            queries = 6
        }else if keyword_text == "",item01 == "",item02 != ""{
            queries = 7
        }else if keyword_text == "",item01 == "",item02 == ""{
            queries = 8
        }
        
        //Dbアクセス開始
        let realm = try! Realm()
        var results = realm.objects(Restaurant.self)
        
        switch queries{
        case 1:
            results = results.filter("(name CONTAINS %@ || place CONTAINS %@ || genres CONTAINS %@ || recommended_menu CONTAINS %@ ) && genres = %@ && %K >= %@ && total_evaluation >= %@" ,keyword_text,keyword_text,keyword_text,keyword_text,item01,item02,item03,item04)
        case 2:
            results = results.filter("(name CONTAINS %@ || place CONTAINS %@ || genres CONTAINS %@ || recommended_menu CONTAINS %@ ) && genres = %@ &&  total_evaluation >= %@" ,keyword_text,keyword_text,keyword_text,keyword_text,item01,item04)
        case 3:
            results = results.filter("(name CONTAINS %@ || place CONTAINS %@ || genres CONTAINS %@ || recommended_menu CONTAINS %@ ) && %K >= %@ && total_evaluation >= %@" ,keyword_text,keyword_text,keyword_text,keyword_text,item02,item03,item04)
        case 4:
            results = results.filter("(name CONTAINS %@ || place CONTAINS %@ || genres CONTAINS %@ || recommended_menu CONTAINS %@ ) && total_evaluation >= %@" ,keyword_text,keyword_text,keyword_text,keyword_text,item04)
        case 5:
            results = results.filter("genres = %@ && %K >= %@ && total_evaluation >= %@" ,item01,item02,item03,item04)
        case 6:
            results = results.filter("genres = %@ && total_evaluation >= %@" ,item01,item04)
        case 7:
            results = results.filter("%K >= %@ && total_evaluation >= %@",item02,item03,item04)
        case 8:
            results = results.filter("total_evaluation >= %@",item04)
        default:
            break
        }
        //詳細ページで表示するため、検索結果のid(プライマリキー)を取得
        idList = [] // idList初期化
        for Restaurant in results {
           idList.append(Restaurant.id)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        genres.delegate = self
        genres.dataSource = self
        genres.tag = 1
        
        evaluation_item.delegate = self
        evaluation_item.dataSource = self
        evaluation_item.tag = 2
        
        evaluation_point.delegate = self
        evaluation_point.dataSource = self
        evaluation_point.tag = 3
        
        evaluation_totalpoint.delegate = self
        evaluation_totalpoint.dataSource = self
        evaluation_totalpoint.tag = 4
        
    }
    

}
