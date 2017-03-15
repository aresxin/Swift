//
//  UserDefaultsTestViewController.swift
//  SwiftDev
//
//  Created by yangjinxin on 2017/3/13.
//  Copyright © 2017年 yangjinxin. All rights reserved.
//

import UIKit

class UserDefaultsTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        preferenceTest()
        userDefaultsSettable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: Test Preference
extension UserDefaultsTestViewController {
    func preferenceTest() {
        let userDefaults = UserDefaults.standard
        
        // Test data.
        var launchAtLogin = true
        var launchCount = 10
        var userInfo: UserInfo? = UserInfo(id: 123, name: "Fox")
        
        // Write preference.
        Preferences[.launchAtLogin] = launchAtLogin
        Preferences[.launchCount] = launchCount
        Preferences[.userInfo] = userInfo
        
        // Read preference.
        launchAtLogin = Preferences[.launchAtLogin]
        launchCount = Preferences[.launchCount]
        userInfo = Preferences[.userInfo]
        
        // Check preferences.
        for (key, value) in userDefaults.dictionaryRepresentation() {
            print("\(key): \(value)")
        }
    }
}

// MARK: Test UserDefaultSettable
extension UserDefaultsTestViewController {
    func userDefaultsSettable()  {
        UserDefaults.TestData.name.store(value: "asd")
        
        let b = UserDefaults.TestData.name.storedValue
        
        print("asds\(b)")
    }
}

extension UserDefaultsTestViewController {
    
}



