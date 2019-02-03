//
//  Search Results Page.swift
//  Meal Management
//
//  Created by 森勇人 on 2019/02/02.
//  Copyright © 2019 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

class Search_Results_Page: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var table_id = 0
    var nameList = [String]()
    var placeList = [String]()
    var picture_List = [UIImage]()
    @IBOutlet weak var tableView: UITableView!
    
    
    //UITableViewの作成
    //セクションの個数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セクション毎の個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idList.count
    }
    
    //セルの作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("確認前")
        let cell = //tableView.dequeueReusableCell(withIdentifier: "dataCell",for: indexPath)
            //UITableViewCell(style: .subtitle, reuseIdentifier: "dataCell")
            tableView.dequeueReusableCell(withIdentifier: "searched_datacell") as! CustomTableViewCell
        print("確認後")
        //print ("\(title[0])")
        //print ("\(title[1])")
        //cell.textLabel?.text = title[0]
        //cell.detailTextLabel?.text = title[1]
        print("***\(nameList[0])***")
        print("***\(placeList[0])***")
        print("***\(picture_List[0])***")
        cell.Searched_name.text = nameList[indexPath.row]
        cell.Searched_place.text = placeList[indexPath.row]
        cell.Searched_ImageView.image = picture_List[indexPath.row]
        
        //print("⭐️セルの作成実行")
        
        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 次の画面へ移動
        //performSegue(withIdentifier: "next", sender: data[indexPath.row])
        //    print("セル選択時")
        //    table_id = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)!
            //assert(segue.destinationViewController.isKindOfClass(detailViewController))
            let Detail_Page = segue.destination as! Detail_Page
            
            Detail_Page.tabel_id = idList[indexPath.row]        }
        //    var Detail_Page = segue.destination as! Detail_Page
        //    Detail_Page.tabel_id = table_id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
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
        print("idList\(idList)")
        print("nameList\(nameList)")
        print("placeList\(placeList)")
            
        
        }
        //idList = []
        
   //     let realm2 = try! Realm()
   //     var results = realm2.objects(Restaurant.self)
        
   //     for Restaurant in results {
            //let dataList1 = [Restaurant.name,Restaurant.place]
            //dataList.append(dataList1)
   //         nameList.append(Restaurant.name)
   //         placeList.append(Restaurant.place)
            
   //         if let picture_data = Restaurant.picture_data {
   //             let picture_image = UIImage(data: Restaurant.picture_data! as Data)
   //             picture_List.append(picture_image!)
   //         }else{
   //             let picture_image = UIImage(named: "default")
   //             picture_List.append(picture_image!)
   //         }
            
            // Do any additional setup after loading the view, typically from a nib.
    //    }

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
