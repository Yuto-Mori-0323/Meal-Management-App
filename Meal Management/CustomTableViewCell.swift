//
//  CustomTableViewCell.swift
//  Meal Management
//
//  Created by 森勇人 on 2019/01/31.
//  Copyright © 2019 yuto mori. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //イメージを表示するImageView
    @IBOutlet weak var ImageView: UIImageView!
    //飲食店の名前を表示するLabel
    @IBOutlet weak var name: UILabel!
    //場所を表示する
    @IBOutlet weak var place: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
