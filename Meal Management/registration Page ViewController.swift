//
//  registration Page ViewController.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/24.
//  Copyright © 2018年 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

class registration_Page_ViewController: UIViewController {
    

    
    @IBAction func gotoTop(_ sender: Any) {
        // 現在のシーンを閉じて元のシーンに戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var name_work01: UITextField!
    
    @IBAction func Registration(_ sender: Any) {
        let realm = try! Realm()
        //データベースへの登録
        let restaurant1 = Restaurant()
        let name_work02 = name_work01.text!
        restaurant1.name = name_work02
        
        try! realm.write() {
            realm.add(restaurant1)
        }
   }
    
    @IBAction func Update(_ sender: Any) {
        let realm = try! Realm()
        //データベースの更新
        let results = realm.objects(Restaurant.self)
        
        if let restaurant = results.first {
            // データを更新
            try! realm.write() {
                restaurant.name = "吉野家"
            }
            
            // write()に渡すブロックの外だと例外発生
            //      dog.name = "First"
        }
    }
    
    
    
    @IBAction func Check(_ sender: Any) {
        let realm = try! Realm()
        //データベース内に保存してある全てのrestaurantモデルを取り出す
        let results = realm.objects(Restaurant.self)
        
        print("results.count: \(results.count)")
        
        for Restaurant in results {
            print("name: \(Restaurant.name)")
        }
    }
    
    
    @IBAction func Delete(_ sender: Any) {
        // Realmのインスタンスを取得
        let realm = try! Realm()
        
        // Realmに保存されてるrestaurantオブジェクトを全て取得
        let results = realm.objects(Restaurant.self)
        
        if let restaurant = results.last {
            
            // さようなら・・・
            try! realm.write() {
                realm.delete(restaurant)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
