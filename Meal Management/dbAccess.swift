//
//  dbAccess.swift
//  Meal Management
//
//  Created by 森勇人 on 2019/02/03.
//  Copyright © 2019 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

//DBにアクセスする処理をまとめて本クラスに記述
class dbAccess: UIViewController {
    var nameList = [String]() //店名
    var placeList = [String]() //場所
    var picture_List = [UIImage]() //画像
    var idList = [Int]()
    
    //DBの再構築(DBの構造が変更された場合のみ初期化)
    func dbRebuilding() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
    }
    
    //DBのLISTを全取得
    func listGet() ->([String],[String],[UIImage]) {
        let realm = try! Realm()
        var results = realm.objects(Restaurant.self)
        
        for Restaurant in results {
            nameList.append(Restaurant.name)
            placeList.append(Restaurant.place)
            
            if let picture_data = Restaurant.picture_data {
                let picture_image = UIImage(data: Restaurant.picture_data! as Data)
                picture_List.append(picture_image!)
            }else{
                let picture_image = UIImage(named: "default")
                picture_List.append(picture_image!)
            }
       
        }
        return (nameList,placeList,picture_List)
    }
    
    //検索されたDBのリストを取得
    func searched_listGet(idList:[Int]) -> ([String],[String],[UIImage]) {
        let realm = try! Realm()
        
        //idListに格納されたデータのみ抽出
        for id in idList{
            if let Object = realm.object(ofType:Restaurant.self,forPrimaryKey: id) {
                nameList.append(Object.name)
                placeList.append(Object.place)
            
                if let picture_data = Object.picture_data {
                    let picture_image = UIImage(data: Object.picture_data! as Data)
                    picture_List.append(picture_image!)
                }else{
                    let picture_image = UIImage(named: "default")
                    picture_List.append(picture_image!)
                }
            }
        }
        return (nameList,placeList,picture_List)
    }
    
    //DBへの新規登録
    func dbRegistration(restaurant:Restaurant){
        let realm = try! Realm()
        
        //DBの中で最もidが大きいものに1を足して新規のidを採番する
        var maxId: Int { return try! Realm().objects(Restaurant.self).sorted(byKeyPath:"id").last?.id ?? 0 }
        restaurant.id = maxId + 1
        
        try! realm.write() {
            realm.add(restaurant)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
