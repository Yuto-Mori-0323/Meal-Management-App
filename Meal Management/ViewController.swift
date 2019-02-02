//
//  ViewController.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/23.
//  Copyright © 2018年 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

var cflag = 0 //グローバル変数

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        return nameList.count
    }
    
    //セルの作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = //tableView.dequeueReusableCell(withIdentifier: "dataCell",for: indexPath)
        //UITableViewCell(style: .subtitle, reuseIdentifier: "dataCell")
            tableView.dequeueReusableCell(withIdentifier: "dataCell") as! CustomTableViewCell
        //print ("\(title[0])")
        //print ("\(title[1])")
        //cell.textLabel?.text = title[0]
        //cell.detailTextLabel?.text = title[1]
        print("***\(nameList[0])***")
        print("***\(placeList[0])***")
        print("***\(picture_List[0])***")
        cell.name.text = nameList[indexPath.row]
        cell.place.text = placeList[indexPath.row]
        cell.ImageView.image = picture_List[indexPath.row]
        
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
    
    @IBAction func comeHome(segue: UIStoryboardSegue){
        
    }
   
    
    @IBAction func gotoRegistration(_ sender: Any) {
        // 移動先のビューコントローラを参照する
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Registration Page")
        // トランジションの映像効果を指定する
        nextVC?.modalTransitionStyle = .coverVertical
        // シーンを移動する
        present(nextVC!, animated: true, completion: nil)
    }
    
    @IBAction func gotoSearch(_ sender: Any) {
        // 移動先のビューコントローラを参照する
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Search Page")
        // トランジションの映像効果を指定する
        nextVC?.modalTransitionStyle = .coverVertical
        // シーンを移動する
        present(nextVC!, animated: true, completion: nil)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? UITableViewCell {
        let indexPath = self.tableView.indexPath(for: cell)!
        //assert(segue.destinationViewController.isKindOfClass(detailViewController))
        let Detail_Page = segue.destination as! Detail_Page
        Detail_Page.tabel_id = indexPath.row
    }
    //    var Detail_Page = segue.destination as! Detail_Page
    //    Detail_Page.tabel_id = table_id
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        let realm = try! Realm(configuration: config)
        
        let realm2 = try! Realm()
        var results = realm2.objects(Restaurant.self)
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewDidDisappear(animated)
        if cflag == 1{
        //    tableView.delegate = self
        //    tableView.dataSource = self
            
            let realm = try! Realm()
            var results = realm.objects(Restaurant.self)
            
            nameList = []
            placeList = []
            picture_List = []
            
            for Restaurant in results {
                //let dataList1 = [Restaurant.name,Restaurant.place]
                //dataList.append(dataList1)
                nameList.append(Restaurant.name)
                placeList.append(Restaurant.place)
                print("Restaurant.picture_data\(Restaurant.picture_data)")
                if let picture_data = Restaurant.picture_data {
                    let picture_image = UIImage(data: Restaurant.picture_data! as Data)
                    picture_List.append(picture_image!)
                    print("picturedataがnilでない")
                }else{
                    let picture_image = UIImage(named: "default")
                    picture_List.append(picture_image!)
                    print("picturedataがnil")
                }
                
            }
        cflag = 0
        tableView.reloadData()
        
        }else{
        print("cflag\(cflag)")
        }
        
    }


}

