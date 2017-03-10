//
//  ViewController.swift
//  UserDefault
//
//  Created by yangjinxin on 2017/3/9.
//  Copyright © 2017年 yangjinxin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UserDefaults.TestData.name.store(value: "asd")
        
        let b = UserDefaults.TestData.name.storedValue
        
        print("asds\(b)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

