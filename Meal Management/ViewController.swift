//
//  ViewController.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/23.
//  Copyright © 2018年 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

var cflag = 0 //登録画面(registration Page)に値を引き継ぎたいため、クラス外に変数を定義

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        return nameList.count
    }
    
    //セルの作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // カスタムセルを使用
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "dataCell") as! CustomTableViewCell
   
        cell.name.text = nameList[indexPath.row]
        cell.place.text = placeList[indexPath.row]
        cell.ImageView.image = picture_List[indexPath.row]
        
        return cell
    }
    
    //セル選択時
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //セグエを使用しているため処理はないが、後で処理を追加する場合に備えて記述
    }
    //ここまでUITableViewの作成
    
    //選んだセルのidを詳細ページ(Detail Page)に引き継ぎ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)!
            let Detail_Page = segue.destination as! Detail_Page
            //indexPathは0から、DBに登録しているid(プライマリキー)は1から採番しているため+1する
            Detail_Page.tabel_id = indexPath.row + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let access = dbAccess() //DBアクセスのためインスタンス作成
        access.dbRebuilding()  //DB構造が変化した場合に初期化する
        
        //TableViewに表示するためDBアクセス
        var dblist = access.listGet()
        nameList = dblist.0
        placeList = dblist.1
        picture_List = dblist.2
        
        tableView.delegate = self
        tableView.dataSource = self
   
    }
    
    /*登録画面(registration Page)で新規登録した後backボタンで戻ってきたときに、
      登録したデータも合わせた形で表示するようにDBに再度アクセスする*/
    override func viewWillAppear(_ animated: Bool) {
        //新規登録があった場合
        if cflag == 1{
            let access = dbAccess()
            access.dbRebuilding()
            
            //空にすることで表示の重複をさ避ける
            nameList = []
            placeList = []
            picture_List = []
            
            //TableViewに表示するためDBアクセス
            var dblist = access.listGet()
            nameList = dblist.0
            placeList = dblist.1
            picture_List = dblist.2
            
            cflag = 0
            tableView.reloadData()
        
        }else{
        //新規登録がない場合は何もしない
        }
        
    }


}

