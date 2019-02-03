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
        let cell = tableView.dequeueReusableCell(withIdentifier: "searched_datacell") as! CustomTableViewCell
        cell.Searched_name.text = nameList[indexPath.row]
        cell.Searched_place.text = placeList[indexPath.row]
        cell.Searched_ImageView.image = picture_List[indexPath.row]
        
        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)!
            
            let Detail_Page = segue.destination as! Detail_Page
            
            Detail_Page.tabel_id = idList[indexPath.row]        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let access = dbAccess()
        var dblist = access.searched_listGet(idList:idList)
        
        nameList = dblist.0
        placeList = dblist.1
        picture_List = dblist.2
        
        tableView.delegate = self
        tableView.dataSource = self
 
    }

}
