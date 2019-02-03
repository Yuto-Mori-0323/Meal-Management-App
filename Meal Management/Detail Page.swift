//
//  Detail Page.swift
//  Meal Management
//
//  Created by 森勇人 on 2019/02/02.
//  Copyright © 2019 yuto mori. All rights reserved.
//

import UIKit
import RealmSwift

class Detail_Page: UIViewController {

    var tabel_id = Int()
    @IBOutlet weak var name: UILabel! //店名
    @IBOutlet weak var place: UILabel! //場所
    @IBOutlet weak var genres: UILabel! //ジャンル
    @IBOutlet weak var taste_evaluation: UILabel! //味の評価値
    @IBOutlet weak var atmosphere_evaluation: UILabel! //雰囲気の評価値
    @IBOutlet weak var cost_evaluation: UILabel! //コスパの評価値
    @IBOutlet weak var recommended_menu: UILabel! //オススメメニュー
    @IBOutlet weak var ImageView: UIImageView! //画像
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        /* table_id(プライマリキー)を指定してオブジェクトを取得
        table_idは前画面より取得　*/
        if let Object = realm.object(ofType:Restaurant.self,forPrimaryKey: tabel_id ) {
            
            name.text = Object.name
            place.text = Object.place
            genres.text = Object.genres
            taste_evaluation.text = String(Object.taste_evaluation)
            atmosphere_evaluation.text = String(Object.atmosphere_evaluation)
            cost_evaluation.text = String(Object.cost_evaluation)
            recommended_menu.text = Object.recommended_menu
            
            if let picture_data = Object.picture_data {
                let picture_image = UIImage(data: Object.picture_data! as Data)
                ImageView.image = picture_image
            }else{
                let picture_image = UIImage(named: "default")
                ImageView.image = picture_image
            }
        }
        
    }

}
