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
    
    var dataList = [[String]]()
    @IBOutlet weak var tableView: UITableView!
    
    
 //UITableViewの作成
   //セクションの個数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //セクション毎の個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    //セルの作成
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = //tableView.dequeueReusableCell(withIdentifier: "dataCell",for: indexPath)
        UITableViewCell(style: .subtitle, reuseIdentifier: "dataCell")
        let title = dataList[indexPath.row]
        //print ("\(title[0])")
        //print ("\(title[1])")
        cell.textLabel?.text = title[0]
        cell.detailTextLabel?.text = title[1]
        //print("⭐️セルの作成実行")
        
        return cell
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let realm = try! Realm()
        var results = realm.objects(Restaurant.self)
        
        for Restaurant in results {
        let dataList1 = [Restaurant.name,Restaurant.place]
        dataList.append(dataList1)
        print("\(dataList1)")
        print("\(dataList)")
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        //super.viewDidDisappear(animated)
        if cflag == 1{
        //    tableView.delegate = self
        //    tableView.dataSource = self
            
            let realm = try! Realm()
            var results = realm.objects(Restaurant.self)
            
            dataList = []
            for Restaurant in results {
                let dataList1 = [Restaurant.name,Restaurant.place]
                dataList.append(dataList1)
                print("\(dataList1)")
                print("\(dataList)")
            }
        cflag = 0
        tableView.reloadData()
        
        }else{
        print("cflag\(cflag)")
        }
        
    }


}

