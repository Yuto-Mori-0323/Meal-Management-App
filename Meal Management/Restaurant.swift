//
//  Restaurant.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/31.
//Copyright © 2018 yuto mori. All rights reserved.
//

import Foundation
import RealmSwift

class Restaurant: Object {
    @objc dynamic var id : Int = 0 //管理ID プライマリーキー
    // idをプライマリキーに設定
    override static func primaryKey() -> String? {
        return "id"
    }
    @objc dynamic var name : String = "" //店名
    @objc dynamic var place : String = "" //場所
    @objc dynamic var genres : String = "中華" //ジャンル
    @objc dynamic var taste_evaluation : Int = 0 //味の評価
    @objc dynamic var atmosphere_evaluation : Int = 0 //雰囲気の評価
    @objc dynamic var cost_evaluation : Int = 0 //コスパの評価　
    @objc dynamic var total_evaluation : Int = 0 //合計点
    @objc dynamic var recommended_menu : String = "" //オススメメニュー
    /*RealmはUIImageを保存できないためNSDataとして画像を保存
    ただ保存できる容量に限度があるため、別の保存方式(画像の保存先のパスを保存する等)
    の検討余地あり*/
    @objc dynamic var picture_data: NSData? = nil //画像
}
