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
    var nameList = [String]() //店名
    var placeList = [String]() //場所
    var picture_List = [UIImage]() //画像
    @IBOutlet weak var tableView: UITableView!
    
    
    //ここからUITableViewの作成
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
        //カスタムセルを使用
        let cell = tableView.dequeueReusableCell(withIdentifier: "searched_datacell") as! CustomTableViewCell
        cell.Searched_name.text = nameList[indexPath.row]
        cell.Searched_place.text = placeList[indexPath.row]
        cell.Searched_ImageView.image = picture_List[indexPath.row]
        
        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セグエを使用しているため処理はないが、後で処理を追加する場合に備えて記述
    }
    
    //選んだセルのidを詳細ページ(Detail Page)に引き継ぎ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)!
            let Detail_Page = segue.destination as! Detail_Page
            Detail_Page.tabel_id = idList[indexPath.row]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TableViewに表示するためDBアクセス
        let access = dbAccess()
        var dblist = access.searched_listGet(idList:idList)
        
        nameList = dblist.0
        placeList = dblist.1
        picture_List = dblist.2
        
        tableView.delegate = self
        tableView.dataSource = self
 
    }

}
