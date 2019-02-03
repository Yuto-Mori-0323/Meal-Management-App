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
        let cell = //
            tableView.dequeueReusableCell(withIdentifier: "dataCell") as! CustomTableViewCell
   
        cell.name.text = nameList[indexPath.row]
        cell.place.text = placeList[indexPath.row]
        cell.ImageView.image = picture_List[indexPath.row]
        
        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let cell = sender as? UITableViewCell {
        let indexPath = self.tableView.indexPath(for: cell)!
        //assert(segue.destinationViewController.isKindOfClass(detailViewController))
        let Detail_Page = segue.destination as! Detail_Page
        Detail_Page.tabel_id = indexPath.row + 1
    }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let access = dbAccess()
        access.dbRebuilding()
        
        var dblist = access.listGet()
        nameList = dblist.0
        placeList = dblist.1
        picture_List = dblist.2
        
        tableView.delegate = self
        tableView.dataSource = self
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if cflag == 1{
        
            let access = dbAccess()
            access.dbRebuilding()
            
            nameList = []
            placeList = []
            picture_List = []
            
            var dblist = access.listGet()
            nameList = dblist.0
            placeList = dblist.1
            picture_List = dblist.2
            
        cflag = 0
        tableView.reloadData()
        
        }else{
            print("cflag\(cflag)")
        }
        
    }


}

