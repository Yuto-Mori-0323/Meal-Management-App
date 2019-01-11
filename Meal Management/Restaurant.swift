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
    
    @objc dynamic var name : String = "" //店名
    @objc dynamic var place : String = "" //場所
    @objc dynamic var genres : String = "" //ジャンル
 //   @objc dynamic var timeZone :String = ""
    @objc dynamic var taste_evaluation : String = ""
 //   @objc dynamic var recommended_menu : String = ""
    @objc dynamic var atmosphere_evaluation : String = ""
    @objc dynamic var cost_evaluation : String = ""
    //   @objc dynamic var use :String = ""
 //   @objc dynamic var use :String = ""
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
