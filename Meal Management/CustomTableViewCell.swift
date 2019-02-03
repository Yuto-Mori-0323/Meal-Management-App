//
//  CustomTableViewCell.swift
//  Meal Management
//
//  Created by 森勇人 on 2019/01/31.
//  Copyright © 2019 yuto mori. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

  //最初の画面のTableViewCell
    //イメージを表示するImageView
    @IBOutlet weak var ImageView: UIImageView!
    //飲食店の名前を表示するLabel
    @IBOutlet weak var name: UILabel!
    //場所を表示する
    @IBOutlet weak var place: UILabel!
    
  //検索結果ひ表示画面のTableViewCell
    //イメージを表示するImageView
    @IBOutlet weak var Searched_ImageView: UIImageView!
    //飲食店の名前を表示するLabel
    @IBOutlet weak var Searched_name: UILabel!
    //場所を表示する
    @IBOutlet weak var Searched_place: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
