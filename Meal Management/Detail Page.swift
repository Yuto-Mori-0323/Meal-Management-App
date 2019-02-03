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
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var taste_evaluation: UILabel!
    @IBOutlet weak var atmosphere_evaluation: UILabel!
    @IBOutlet weak var cost_evaluation: UILabel!
    @IBOutlet weak var recommended_menu: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("tabel_id\(tabel_id)")
        
        let realm = try! Realm()
        // プライマリキーを指定してオブジェクトを取得
        if let Object = realm.object(ofType:Restaurant.self,forPrimaryKey: tabel_id ) {
            
            print("Object \(Object)")
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
