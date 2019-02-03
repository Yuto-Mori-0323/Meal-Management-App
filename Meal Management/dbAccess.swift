//
//  dbAccess.swift
//  Meal Management
//
//  Created by 森勇人 on 2019/02/03.
//  Copyright © 2019 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

class dbAccess: UIViewController {
    
    var nameList = [String]()
    var placeList = [String]()
    var picture_List = [UIImage]()
    var idList = [Int]()
    
    //DBの再構築
    func dbRebuilding() {
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
    }
    
    //DBのLISTを全取得
    func listGet() ->([String],[String],[UIImage]) {
        let realm = try! Realm()
        var results = realm.objects(Restaurant.self)
        
        for Restaurant in results {
            //let dataList1 = [Restaurant.name,Restaurant.place]
            //dataList.append(dataList1)
            nameList.append(Restaurant.name)
            placeList.append(Restaurant.place)
            
            if let picture_data = Restaurant.picture_data {
                let picture_image = UIImage(data: Restaurant.picture_data! as Data)
                picture_List.append(picture_image!)
            }else{
                let picture_image = UIImage(named: "default")
                picture_List.append(picture_image!)
            }
            
            // Do any additional setup after loading the view, typically from a nib.
        }
        return (nameList,placeList,picture_List)
    }
    
    //検索されたDBのリストを取得
    func searched_listGet(idList:[Int]) -> ([String],[String],[UIImage]) {
      let realm = try! Realm()
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
        var maxId: Int { return try! Realm().objects(Restaurant.self).sorted(byKeyPath:"id").last?.id ?? 0 }
        restaurant.id = maxId + 1
        try! realm.write() {
            realm.add(restaurant)
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
