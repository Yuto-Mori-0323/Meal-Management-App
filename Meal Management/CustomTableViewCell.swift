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
    @IBOutlet weak var ImageView: UIImageView! //画像
    @IBOutlet weak var name: UILabel! //店名
    @IBOutlet weak var place: UILabel! //場所
    
    //検索結果表示画面(Search_Results_Page)のTableViewCell
    @IBOutlet weak var Searched_ImageView: UIImageView! //画像
    @IBOutlet weak var Searched_name: UILabel! //店名
    @IBOutlet weak var Searched_place: UILabel! //場所
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
