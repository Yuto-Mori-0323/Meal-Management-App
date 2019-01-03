//
//  ViewController.swift
//  Meal Management
//
//  Created by 森勇人 on 2018/12/23.
//  Copyright © 2018年 yuto mori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }


}

